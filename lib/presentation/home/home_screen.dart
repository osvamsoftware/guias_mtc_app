import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/auth/login/login_screen.dart';
import 'package:app_remision/presentation/forms/guia_remision_transportista/guia_transportista_form_screen.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/hoja_de_ruta_list_screen.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/list_screen/manifiesto_pasajeros_list_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/list_screen/pesos_medidas_list_screen.dart';
import 'package:app_remision/presentation/home/cubit/home_cubit.dart';
import 'package:app_remision/presentation/settings/settings_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const path = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HomeCubit(
          context.read<LocalFormsRepository>(),
          context.read<VerificacionPesosMedidasRepository>(),
          context.read<HojaDeRutaRepository>(),
          context.read<ManifiestoRepository>())
        ..verifyWifi(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            context.push(AppSettingsScreen.path);
                          },
                          icon: const Icon(Icons.settings, size: 40)),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
                            context.pushReplacement(LoginScreen.path);
                          },
                          icon: const Icon(Icons.logout, size: 40)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Guías y Formularios de Transporte.',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: const Color.fromARGB(255, 43, 144, 190)),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Text('Por favor, seleccione una opción del trámite que desea realizar.'),
                ),
                const SizedBox(height: 40),
                CustomElevatedButton(onPressed: () {}, text: 'Guías de Remisión'),
                const SizedBox(height: 40),
                CustomElevatedButton(
                    onPressed: () => context.push(GuiaTransportistaFormScreen.path), text: 'Guías de Transportista'),
                const SizedBox(height: 40),
                CustomElevatedButton(
                    onPressed: () => context.push(PesosMedidasListScreen.path), text: 'Pesos y Medidas'),
                const SizedBox(height: 40),
                CustomElevatedButton(onPressed: () => context.push(HojaDeRutaListScreen.path), text: 'Hoja de Ruta'),
                const SizedBox(height: 40),
                CustomElevatedButton(
                    onPressed: () => context.push(ManifiestoListScreen.path), text: 'Manifiesto de Pasajeros'),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = ThemeColors.primaryRed,
    this.borderRadius,
    this.textColor = Colors.white,
    this.fontSize,
    this.padding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          elevation: elevation ?? 2.0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
