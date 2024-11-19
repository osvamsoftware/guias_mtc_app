import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/auth/loading_screen.dart';
import 'package:app_remision/presentation/auth/login/login_screen.dart';
import 'package:app_remision/presentation/auth/signUp/signup_screen.dart';
import 'package:app_remision/presentation/forms/guia_remision_transportista/guia_transportista_form_screen.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/form_screen/hoja_de_ruta_form_screen.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/hoja_de_ruta_details_screen.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/hoja_de_ruta_list_screen.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/form_screen/manifest_form_screen.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/list_screen/manifiesto_pasajeros_detail_screen.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/list_screen/manifiesto_pasajeros_list_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/form/pesos_medidas_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/list_screen/details_pesos_medidas_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/list_screen/pesos_medidas_list_screen.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/settings/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouterConfiguration {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: LoadingScreen.path,
    routes: [
      GoRoute(path: SignUpScreen.path, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: HomeScreen.path, builder: (context, state) => const HomeScreen()),
      GoRoute(path: LoadingScreen.path, builder: (context, state) => const LoadingScreen()),
      GoRoute(path: LoginScreen.path, builder: (context, state) => const LoginScreen()),
      GoRoute(path: PesosMedidasListScreen.path, builder: (context, state) => const PesosMedidasListScreen()),
      GoRoute(path: HojaDeRutaListScreen.path, builder: (context, state) => const HojaDeRutaListScreen()),
      GoRoute(path: ManifiestoListScreen.path, builder: (context, state) => const ManifiestoListScreen()),
      GoRoute(path: AppSettingsScreen.path, builder: (context, state) => const AppSettingsScreen()),
      //! --------------- FORMS PAGES
      GoRoute(
          path: PesosMedidasFormScreen.path,
          builder: (context, state) {
            if (state.extra != null) {
              return PesosMedidasFormScreen(verificacionModel: state.extra as VerificacionPesosMedidasModel);
            } else {
              return const PesosMedidasFormScreen();
            }
          }),
      GoRoute(
          path: HojaDeRutaFormScreen.path,
          builder: (context, state) {
            if (state.extra != null) {
              return HojaDeRutaFormScreen(
                hojaDeRutaModel: state.extra as HojaDeRutaModel,
              );
            } else {
              return const HojaDeRutaFormScreen();
            }
          }),
      GoRoute(
          path: ManifiestoFormScreen.path,
          builder: (context, state) {
            if (state.extra != null) {
              return ManifiestoFormScreen(manifiestoModel: state.extra as ManifiestoModel);
            } else {
              return const ManifiestoFormScreen();
            }
          }),
      GoRoute(
          path: GuiaTransportistaFormScreen.path,
          builder: (context, state) {
            if (state.extra != null) {
              return const GuiaTransportistaFormScreen();
            } else {
              return const GuiaTransportistaFormScreen();
            }
          }),
      //! -------------- DETAILS PAGES
      GoRoute(
          path: VerificacionPesosMedidasDetail.path,
          builder: (context, state) {
            final VerificacionPesosMedidasModel model = state.extra as VerificacionPesosMedidasModel;
            return VerificacionPesosMedidasDetail(verificacion: model);
          }),
      GoRoute(
          path: ManifiestoDetailsScreen.path,
          builder: (context, state) {
            final ManifiestoModel model = state.extra as ManifiestoModel;
            return ManifiestoDetailsScreen(manifiesto: model);
          }),
      GoRoute(
          path: HojaDeRutaDetailScreen.path,
          builder: (context, state) {
            final HojaDeRutaModel model = state.extra as HojaDeRutaModel;
            return HojaDeRutaDetailScreen(hojaDeRuta: model);
          }),
    ],
    redirect: (context, state) async {
      final goingTo = state.matchedLocation;
      final AuthState authState = context.read<AuthCubit>().state;
      if (authState is AuthUnauthenticated &&
          goingTo != SignUpScreen.path &&
          goingTo != LoginScreen.path &&
          goingTo != LoadingScreen.path) {
        return LoginScreen.path;
      } else {
        return null;
      }
    },
  );
}
