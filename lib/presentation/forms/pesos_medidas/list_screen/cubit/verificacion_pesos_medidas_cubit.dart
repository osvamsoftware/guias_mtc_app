import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verificacion_pesos_medidas_state.dart';

class PesosMedidasListCubit extends Cubit<PesosMedidasListState> {
  final VerificacionPesosMedidasRepository repository;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;

  final ScrollController scrollController = ScrollController();
  PesosMedidasListCubit({required this.repository}) : super(const PesosMedidasListInitial()) {
    scrollController.addListener(_onScroll);
  }
//! repository functions
  Future<void> loadVerificaciones(String usuarioId, {int limit = 10}) async {
    if (state is PesosMedidasLoading || !hasMore) return;

    emit(PesosMedidasLoading(verificaciones: state.verificaciones));

    try {
      final result = await repository.getVerificacionesByUserWithPagination(
        usuarioId,
        limit,
        lastDocument: lastDocument,
      );

      List<VerificacionPesosMedidasModel> nuevasVerificaciones = result['verificaciones'];
      DocumentSnapshot? newLastDocument = result['lastDocument'];

      if (nuevasVerificaciones.isNotEmpty) {
        lastDocument = newLastDocument;
      } else {
        hasMore = false;
      }

      emit(PesosMedidasListSuccess(
          verificaciones: [...state.verificaciones, ...nuevasVerificaciones], hasMore: hasMore));
    } catch (e) {
      emit(PesosMedidasFailure(error: e.toString(), verificaciones: state.verificaciones));
    }
  }

  //! local functions
  void resetPagination() {
    lastDocument = null;
    hasMore = true;
    emit(const PesosMedidasListInitial());
  }

  void _onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        hasMore &&
        state is! PesosMedidasLoading) {
      loadVerificaciones(state.verificaciones[0].userId ?? '----');
    }
  }
}
