import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'manifiesto_usuarios_list_state.dart';

class ManifiestoListCubit extends Cubit<ManifiestoListState> {
  final ManifiestoRepository repository;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;
  final ScrollController scrollController = ScrollController();

  ManifiestoListCubit({required this.repository}) : super(const ManifiestoListInitial()) {
    scrollController.addListener(_onScroll);
  }

  //! Función para obtener la lista de manifiestos con paginación
  Future<void> loadManifiestos({int limit = 10, String userId = ''}) async {
    if (state is ManifiestoLoading || !hasMore) return;

    emit(ManifiestoLoading(manifiestos: state.manifiestos));

    try {
      final result = await repository.getManifiestosByUserWithPagination(
        userId,
        limit,
        lastDocument: lastDocument,
      );

      List<ManifiestoModel> nuevosManifiestos = (result['manifiestos']);

      if (nuevosManifiestos.isNotEmpty) {
        lastDocument = result['lastDocument'] as DocumentSnapshot?;
      } else {
        hasMore = false;
      }

      emit(ManifiestoListSuccess(
        manifiestos: [...state.manifiestos, ...nuevosManifiestos],
        hasMore: hasMore,
      ));
    } catch (e) {
      emit(ManifiestoFailure(error: e.toString(), manifiestos: state.manifiestos));
    }
  }

  //! Reinicia la paginación y el estado
  void resetPagination() {
    lastDocument = null;
    hasMore = true;
    emit(const ManifiestoListInitial());
  }

  //! Listener de scroll para cargar más manifiestos cuando se llega al final de la lista
  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        hasMore &&
        state is! ManifiestoLoading) {
      loadManifiestos();
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose(); // Asegúrate de liberar el controlador de scroll
    return super.close();
  }
}
