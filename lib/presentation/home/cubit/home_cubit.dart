import 'package:app_remision/core/helpers/signature/connectivity/wifi_settings.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalFormsRepository _localFormsRepository;
  final VerificacionPesosMedidasRepository _pesosMedidasRepository;
  final HojaDeRutaRepository _hojaDeRutaRepository;
  final ManifiestoRepository _manifiestoRepository;
  HomeCubit(
      this._localFormsRepository, this._pesosMedidasRepository, this._hojaDeRutaRepository, this._manifiestoRepository)
      : super(const HomeState());

  Future<void> verifyWifi() async {
    final hasWifi = await hasInternetConnection();
    if (hasWifi) {
      final verificationList = await _localFormsRepository.getPendingVerificaciones();
      if (verificationList.isNotEmpty) {
        for (var verification in verificationList) {
          await _pesosMedidasRepository.createVerificacion(verification);
        }
        await _localFormsRepository.clearPendingVerificaciones();
      }
      final hojasDeRutaList = await _localFormsRepository.getPendingHojasDeRuta();
      if (hojasDeRutaList.isNotEmpty) {
        for (var hojaRuta in hojasDeRutaList) {
          await _hojaDeRutaRepository.createHojaDeRuta(hojaRuta);
        }
        await _localFormsRepository.clearPendingHojasDeRuta();
      }
      final manifiestoList = await _localFormsRepository.getPendingManifiestos();
      if (manifiestoList.isNotEmpty) {
        for (var manifiesto in manifiestoList) {
          await _manifiestoRepository.createManifiesto(manifiesto);
        }
        await _localFormsRepository.clearPendingManifiestos();
      }
    }
  }
}
