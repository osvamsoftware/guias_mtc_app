part of 'hoja_de_ruta_list_cubit.dart';

abstract class HojaDeRutaListState extends Equatable {
  final List<HojaDeRutaModel> hojasDeRuta;

  const HojaDeRutaListState({this.hojasDeRuta = const []});

  @override
  List<Object> get props => [hojasDeRuta];
}

class HojaDeRutaListInitial extends HojaDeRutaListState {
  const HojaDeRutaListInitial();
}

class HojaDeRutaLoading extends HojaDeRutaListState {
  const HojaDeRutaLoading({required super.hojasDeRuta});
}

class HojaDeRutaListSuccess extends HojaDeRutaListState {
  final bool hasMore;

  const HojaDeRutaListSuccess({required super.hojasDeRuta, required this.hasMore});

  @override
  List<Object> get props => [hojasDeRuta, hasMore];
}

class HojaDeRutaFailure extends HojaDeRutaListState {
  final String error;

  const HojaDeRutaFailure({required this.error, required super.hojasDeRuta});

  @override
  List<Object> get props => [error, hojasDeRuta];
}
