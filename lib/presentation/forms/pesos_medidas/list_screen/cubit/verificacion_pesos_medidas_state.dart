part of 'verificacion_pesos_medidas_cubit.dart';

abstract class PesosMedidasListState extends Equatable {
  final List<VerificacionPesosMedidasModel> verificaciones;

  const PesosMedidasListState({this.verificaciones = const []});

  @override
  List<Object?> get props => [verificaciones];
}

class PesosMedidasListInitial extends PesosMedidasListState {
  const PesosMedidasListInitial() : super();
}

class PesosMedidasLoading extends PesosMedidasListState {
  const PesosMedidasLoading({super.verificaciones}) : super();
  @override
  List<Object?> get props => [verificaciones];
}

class PesosMedidasListSuccess extends PesosMedidasListState {
  final bool hasMore;

  const PesosMedidasListSuccess({required super.verificaciones, this.hasMore = true}) : super();

  @override
  List<Object?> get props => [verificaciones, hasMore];
}

class PesosMedidasFailure extends PesosMedidasListState {
  final String error;

  const PesosMedidasFailure({required this.error, required List<VerificacionPesosMedidasModel> verificaciones})
      : super();

  @override
  List<Object?> get props => [error, verificaciones];
}
