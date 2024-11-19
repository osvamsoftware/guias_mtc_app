import 'dart:convert';
import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalFormsRepository {
  Future<void> saveManifiestoLocally(ManifiestoModel manifiesto);
  Future<List<ManifiestoModel>> getPendingManifiestos();
  Future<void> clearPendingManifiestos();

  Future<void> saveHojaDeRutaLocally(HojaDeRutaModel hojaDeRuta);
  Future<List<HojaDeRutaModel>> getPendingHojasDeRuta();
  Future<void> clearPendingHojasDeRuta();

  Future<void> saveVerificacionLocally(VerificacionPesosMedidasModel verificacion);
  Future<List<VerificacionPesosMedidasModel>> getPendingVerificaciones();
  Future<void> clearPendingVerificaciones();
}

class SharedPreferencesLocalFormsRepository extends LocalFormsRepository {
  // Manifiesto methods
  @override
  Future<void> saveManifiestoLocally(ManifiestoModel manifiesto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedManifiestos = prefs.getStringList('pendingManifiestos') ?? [];
    storedManifiestos.add(jsonEncode(manifiesto.toJson(saveDateAsString: true)));
    await prefs.setStringList('pendingManifiestos', storedManifiestos);
  }

  @override
  Future<List<ManifiestoModel>> getPendingManifiestos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedManifiestos = prefs.getStringList('pendingManifiestos') ?? [];
    return storedManifiestos.map((form) => ManifiestoModel.fromJson(jsonDecode(form))).toList();
  }

  @override
  Future<void> clearPendingManifiestos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pendingManifiestos');
  }

  // Hoja de Ruta methods
  @override
  Future<void> saveHojaDeRutaLocally(HojaDeRutaModel hojaDeRuta) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedHojas = prefs.getStringList('pendingHojasDeRuta') ?? [];
    final hojaR = jsonEncode(hojaDeRuta.toJson(saveDateAsString: true));
    storedHojas.add(hojaR);
    await prefs.setStringList('pendingHojasDeRuta', storedHojas);
  }

  @override
  Future<List<HojaDeRutaModel>> getPendingHojasDeRuta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedHojas = prefs.getStringList('pendingHojasDeRuta') ?? [];
    return storedHojas.map((form) => HojaDeRutaModel.fromJson(jsonDecode(form))).toList();
  }

  @override
  Future<void> clearPendingHojasDeRuta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pendingHojasDeRuta');
  }

  // Verificación methods
  @override
  Future<void> saveVerificacionLocally(VerificacionPesosMedidasModel verificacion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedVerificaciones = prefs.getStringList('pendingVerificaciones') ?? [];
    storedVerificaciones.add(jsonEncode(verificacion.toJson(saveDateAsString: true)));
    await prefs.setStringList('pendingVerificaciones', storedVerificaciones);
  }

  @override
  Future<List<VerificacionPesosMedidasModel>> getPendingVerificaciones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedVerificaciones = prefs.getStringList('pendingVerificaciones') ?? [];
    return storedVerificaciones.map((form) => VerificacionPesosMedidasModel.fromJson(jsonDecode(form), '0')).toList();
  }

  @override
  Future<void> clearPendingVerificaciones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pendingVerificaciones');
  }
}
