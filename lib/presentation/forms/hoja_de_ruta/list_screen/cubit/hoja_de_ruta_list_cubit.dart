import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'hoja_de_ruta_list_state.dart';

class HojaDeRutaListCubit extends Cubit<HojaDeRutaListState> {
  final HojaDeRutaRepository repository;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  final ScrollController scrollController = ScrollController();

  HojaDeRutaListCubit({required this.repository}) : super(const HojaDeRutaListInitial()) {
    scrollController.addListener(_onScroll);
  }

  //! Función para obtener la lista de hojas de ruta con paginación
  Future<void> loadHojasDeRuta({int limit = 10, String userId = ''}) async {
    if (state is HojaDeRutaLoading || !hasMore) return;

    emit(HojaDeRutaLoading(hojasDeRuta: state.hojasDeRuta));

    try {
      final QuerySnapshot result =
          await repository.getHojasDeRutaWithPagination(limit: limit, lastDocument: lastDocument, usuarioId: userId);

      List<HojaDeRutaModel> nuevasHojasDeRuta = result.docs.map((doc) {
        return HojaDeRutaModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (nuevasHojasDeRuta.isNotEmpty) {
        lastDocument = result.docs.last;
      } else {
        hasMore = false;
      }

      emit(HojaDeRutaListSuccess(hojasDeRuta: [...state.hojasDeRuta, ...nuevasHojasDeRuta], hasMore: hasMore));
    } catch (e) {
      emit(HojaDeRutaFailure(error: e.toString(), hojasDeRuta: state.hojasDeRuta));
    }
  }

  //! Reinicia la paginación y el estado
  void resetPagination() {
    lastDocument = null;
    hasMore = true;
    emit(const HojaDeRutaListInitial());
  }

  //! Listener de scroll para cargar más hojas de ruta cuando se llega al final de la lista
  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        hasMore &&
        state is! HojaDeRutaLoading) {
      loadHojasDeRuta();
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose(); // Asegúrate de liberar el controlador de scroll
    return super.close();
  }
}
