import 'package:app_remision/domain/repository/auth_repository.dart';
import 'package:app_remision/presentation/auth/loading_screen.dart';
import 'package:app_remision/presentation/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_remision/presentation/auth/signUp/cubit/signup_cubit.dart';
import 'package:app_remision/presentation/auth/signUp/cubit/signup_state.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  static const path = '/signup';

  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: BlocProvider(
        create: (_) => SignUpCubit(context.read<AuthRepository>()),
        child: Builder(builder: (context) {
          return const Center(child: SignUpView());
        }),
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocListener<SignUpCubit, SignUpFormState>(
        listener: (context, state) {
          if (state.status.isInProgress) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status.isSuccess) {
            Navigator.pop(context);
            context.pushReplacement(LoadingScreen.path);
          }

          if (state.status.isFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? '---')),
            );
          }
        },
        // child: Text('COntainer '),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _NameInput(),
              _EmailInput(),
              _PasswordInput(),
              _PhoneInput(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<SignUpCubit>().submit();
                },
                //TODO: CONSTANT TEXT
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Nombre',
          errorText: state.name.isNotValid ? state.name.error : null,
          onChanged: (value) => context.read<SignUpCubit>().nameChanged(value),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Correo electrónico',
          errorText: state.email.isNotValid ? state.email.error : null,
          onChanged: (value) => context.read<SignUpCubit>().emailChanged(value),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Contraseña',
          errorText: state.password.isNotValid ? state.password.error : null,
          oscureText: true,
          onChanged: (value) => context.read<SignUpCubit>().passwordChanged(value),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Teléfono',
          keyboardType: const TextInputType.numberWithOptions(),
          errorText: state.phone.isNotValid ? state.phone.error : null,
          onChanged: (value) => context.read<SignUpCubit>().phoneChanged(value),
        );
      },
    );
  }
}
