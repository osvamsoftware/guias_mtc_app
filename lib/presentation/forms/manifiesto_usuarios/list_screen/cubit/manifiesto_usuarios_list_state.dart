part of 'manifiesto_usuarios_list_cubit.dart';

abstract class ManifiestoListState extends Equatable {
  final List<ManifiestoModel> manifiestos;

  const ManifiestoListState({this.manifiestos = const []});

  @override
  List<Object> get props => [manifiestos];
}

class ManifiestoListInitial extends ManifiestoListState {
  const ManifiestoListInitial();
}

class ManifiestoLoading extends ManifiestoListState {
  const ManifiestoLoading({required super.manifiestos});
}

class ManifiestoListSuccess extends ManifiestoListState {
  final bool hasMore;

  const ManifiestoListSuccess({required super.manifiestos, required this.hasMore});

  @override
  List<Object> get props => [manifiestos, hasMore];
}

class ManifiestoFailure extends ManifiestoListState {
  final String error;

  const ManifiestoFailure({required this.error, required super.manifiestos});

  @override
  List<Object> get props => [error, manifiestos];
}
