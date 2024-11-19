import 'package:app_remision/domain/repository/auth_repository.dart';
import 'package:app_remision/presentation/auth/loading_screen.dart';
import 'package:app_remision/presentation/auth/signUp/signup_screen.dart';
import 'package:app_remision/presentation/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_remision/presentation/auth/login/cubit/login_cubit.dart';
import 'package:app_remision/presentation/auth/login/cubit/login_state.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const path = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthRepository>()),
          child: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          context.pushReplacement(LoadingScreen.path);
        } else if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Error al iniciar sesión')),
          );
        }
      },
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _EmailField(),
            const SizedBox(height: 16),
            const _PasswordField(),
            const SizedBox(height: 32),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.isValidate
                      ? () {
                          context.read<LoginCubit>().submit();
                        }
                      : null,
                  //TODO:
                  child: const Text('Iniciar sesión'),
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.push(SignUpScreen.path);
              },
              //TODO:
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      keyboardType: TextInputType.emailAddress,
      labelText: 'Correo Electrónico',
      onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
      validator: (value) {
        final email = context.read<LoginCubit>().state.email;
        return email.isNotValid ? email.error : null;
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      oscureText: true,
      labelText: 'Contraseña',
      onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
      validator: (value) {
        final password = context.read<LoginCubit>().state.password;
        return password.isNotValid ? password.error : null;
      },
    );
  }
}
