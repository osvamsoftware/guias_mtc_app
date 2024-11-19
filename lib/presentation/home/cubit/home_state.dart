part of 'home_cubit.dart';

enum WifiStatus { notConnect, connect }

class HomeState extends Equatable {
  final WifiStatus? wifiStatus;
  const HomeState({this.wifiStatus});

  @override
  List<Object> get props => [wifiStatus ?? ''];
}
