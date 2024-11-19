import 'package:app_remision/core/helpers/signature/cubit/signature_cubit.dart';
import 'package:app_remision/core/helpers/signature/form_functions.dart';
import 'package:app_remision/domain/repository/media_storage_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppSettingsScreen extends StatelessWidget {
  static const path = '/settings';

  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(context.read<MediaStorageRepository>()),
      child: const AppSettingsView(),
    );
  }
}

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración de Archivos')),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listenWhen: (previous, current) => current.status != previous.status,
        listener: (context, settingState) {
          if (settingState.status == SettingsStatus.logoUpdated) {
            context.read<AuthCubit>().checkAuthentication();
          }
          if (settingState.status == SettingsStatus.loading) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cargando logo...')));
          }
        },
        builder: (context, settingState) {
          return BlocConsumer<SignatureCubit, SignatureCState>(
            listenWhen: (previous, current) => current.status != previous.status,
            listener: (context, state) {
              if (state.status == SignatureStatus.loading) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cargando firma...')));
              }

              if (state.status == SignatureStatus.success) {
                context.read<AuthCubit>().checkAuthentication();
              }
            },
            builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (state.status == SignatureStatus.uploading) ...[
                        const CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        const Text('Subiendo firma...'),
                      ],
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                          if (authState.userModel?.signatureUrl != null &&
                              authState.userModel!.signatureUrl!.isNotEmpty) {
                            return Container(
                              color: Colors.white,
                              child: Image.network(context.read<AuthCubit>().state.userModel?.signatureUrl ?? '',
                                  height: 200),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _pickNewSignature(context),
                        child: const Text('Crear nueva firma.'),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, authState) {
                          if (authState.userModel?.logoUrl != null && authState.userModel!.logoUrl!.isNotEmpty) {
                            return Container(
                              color: Colors.white,
                              child:
                                  Image.network(context.read<AuthCubit>().state.userModel?.logoUrl ?? '', height: 200),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () => _pickLogo(context),
                        child: const Text('Seleccionar Nuevo Logo'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _pickNewSignature(BuildContext context) async {
    final signatureCubit = context.read<SignatureCubit>();
    final userCubit = context.read<AuthCubit>();

    final filePath = await showSignatureDialog(context);
    if (filePath != null) {
      signatureCubit.saveSignature(userCubit.state.userModel?.userId ?? '', filePath);
    }
  }

  Future<void> _pickLogo(BuildContext context) async {
    final settingsCubit = context.read<SettingsCubit>();
    final userCubit = context.read<AuthCubit>();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final logoFilePath = pickedFile.path;
      settingsCubit.uploadLogo(userCubit.state.userModel?.userId ?? '', logoFilePath);
    }
  }
}
