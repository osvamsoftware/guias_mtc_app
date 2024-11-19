import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/auth/login/login_screen.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatelessWidget {
  static const path = '/redirect';
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().checkAuthentication();

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) => previous == current || previous != current,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.pushReplacement(HomeScreen.path);
          }
          if (state is AuthUnauthenticated) {
            context.go(LoginScreen.path);
          }
        },
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
