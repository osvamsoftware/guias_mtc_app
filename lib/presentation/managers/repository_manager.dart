import 'package:app_remision/domain/repository/auth_repository.dart';
import 'package:app_remision/domain/repository/guia_transportista_repository.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/media_storage_repository.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/domain/repository/signature_repository.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryManager extends StatelessWidget {
  final Widget child;
  const RepositoryManager({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(create: (context) => FirebaseAuthRepository()),
          RepositoryProvider<VerificacionPesosMedidasRepository>(
              create: (context) => FirebaseVerificacionPesosMedidasRepository()),
          RepositoryProvider<HojaDeRutaRepository>(create: (context) => FirebaseHojaDeRutaRepository()),
          RepositoryProvider<ManifiestoRepository>(create: (context) => FirebaseManifiestoRepository()),
          RepositoryProvider<SignatureRepository>(create: (context) => FirebaseSignatureRepository()),
          RepositoryProvider<MediaStorageRepository>(create: (context) => FirebaseMediaStorageRepository()),
          RepositoryProvider<LocalFormsRepository>(create: (context) => SharedPreferencesLocalFormsRepository()),
          RepositoryProvider<GuiaTransportistaRepository>(create: (context) => SunatGuiaTransportistaRepository()),
        ],
        child: Builder(builder: (context) {
          return child;
        }));
  }
}
