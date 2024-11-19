import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/form_screen/cubit/manifiesto_usuarios_cubit.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:app_remision/presentation/shared/widgets/custom_divider.dart';
import 'package:app_remision/presentation/shared/widgets/custom_text_field.dart';
import 'package:app_remision/core/helpers/signature/cubit/signature_cubit.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManifiestoFormScreen extends StatelessWidget {
  final ManifiestoModel? manifiestoModel;
  static const path = '/manifiesto';

  const ManifiestoFormScreen({super.key, this.manifiestoModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManifiestoCubit(context.read<ManifiestoRepository>(), context.read<LocalFormsRepository>())
        ..initEdit(manifiestoModel),
      child: ManifiestoFormView(manifiestoModel: manifiestoModel),
    );
  }
}

class ManifiestoFormView extends StatelessWidget {
  final ManifiestoModel? manifiestoModel;

  const ManifiestoFormView({super.key, this.manifiestoModel});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<AuthCubit>();
    final manifiestoCubit = context.read<ManifiestoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Manifiesto de Pasajeros'),
      ),
      body: BlocListener<SignatureCubit, SignatureCState>(
        listener: (context, state) {
          if (state.status == SignatureStatus.loading) CustomDialogs.loadingDialog(context);
          if (state.status == SignatureStatus.success) {
            context.pop();
            userCubit.checkAuthentication();
            manifiestoCubit.setSignatureUrl(state.urlImage ?? '');
          }
        },
        child: BlocConsumer<ManifiestoCubit, ManifiestoFormState>(
          listenWhen: (previous, current) => current.status != previous.status,
          listener: (context, state) {
            if (state.status.isInProgress) {
              CustomDialogs.loadingDialog(context);
            } else if (state.status.isSuccess) {
              context.pop();
              CustomDialogs.successDialog(
                context: context,
                successMessage: 'Se ha creado el Manifiesto de Pasajeros exitosamente.',
                onPressed: () => context.pushReplacement(HomeScreen.path),
              );
            } else if (state.status.isFailure) {
              context.pop();
              CustomDialogs.errorDialog(context, 'Hubo un error ${state.message}');
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _RazonSocialInput(),
                    _DireccionInput(),
                    _CorreoElectronicoInput(),
                    _TelefonoInput(),
                    _FechaViajeInput(),
                    _PlacaVehicularInput(),
                    _RutaInput(),
                    _ModalidadServicioInput(),
                    const CustomNamedDivider(label: 'Pasajeros'),
                    const Text('Por favor llene los datos de pasajero, y presione el botón "Agregar Pasajero"'),
                    const SizedBox(height: 10),
                    ...List.generate(
                      state.pasajeros.length,
                      (index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(3),
                          color: Colors.grey.withOpacity(.05),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 300,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text("Nombre: ${state.pasajeros[index].apellidosNombres}"),
                                    Text("Documento: ${state.pasajeros[index].documentoIdentidad}"),
                                    Text("Edad: ${state.pasajeros[index].edad.toString()}")
                                  ])),
                              IconButton(
                                  onPressed: () => context.read<ManifiestoCubit>().deletePasajero(index),
                                  icon: Icon(Icons.delete, color: Colors.red.shade400))
                            ],
                          ),
                        );
                      },
                    ),
                    const _PasajeroInput(),
                    TextButton(
                      onPressed: () => context.read<ManifiestoCubit>().agregarPasajero(),
                      child: const Text('Agregar Pasajero', style: TextStyle(color: ThemeColors.secondaryBlue)),
                    ),
                    const SizedBox(height: 15),
                    (manifiestoModel != null)
                        ? ElevatedButton(
                            onPressed: () => context.read<ManifiestoCubit>().editForm(manifiestoModel!),
                            child: const Text('Editar y Guardar'))
                        : ElevatedButton(
                            onPressed: () => context
                                .read<ManifiestoCubit>()
                                .submitForm(context.read<AuthCubit>().state.userModel?.userId ?? ''),
                            child: const Text('Enviar')),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Widget para Razon Social
class _RazonSocialInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Razón Social',
      controller: context.read<ManifiestoCubit>().razonSocialController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().razonSocialChanged(value);
      },
      validator: (value) {
        final razonSocial = context.read<ManifiestoCubit>().state.razonSocial;
        return razonSocial.isNotValid ? razonSocial.error : null;
      },
    );
  }
}

// Widget para Dirección
class _DireccionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Dirección',
      controller: context.read<ManifiestoCubit>().direccionController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().direccionChanged(value);
      },
      validator: (value) {
        final direccion = context.read<ManifiestoCubit>().state.direccion;
        return direccion.isNotValid ? direccion.error : null;
      },
    );
  }
}

// Widget para Teléfono
class _TelefonoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Teléfono',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<ManifiestoCubit>().telefonoController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().telefonoChanged(value);
      },
      validator: (value) {
        final telefono = context.read<ManifiestoCubit>().state.telefono;
        return telefono.isNotValid ? telefono.error : null;
      },
    );
  }
}

// Widget para Correo Electrónico
class _CorreoElectronicoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Correo Electrónico',
      controller: context.read<ManifiestoCubit>().correoElectronicoController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().correoElectronicoChanged(value);
      },
      validator: (value) {
        final correoElectronico = context.read<ManifiestoCubit>().state.correoElectronico;
        return correoElectronico.isNotValid ? correoElectronico.error : null;
      },
    );
  }
}

// Widget para Fecha de Viaje
class _FechaViajeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Fecha de Viaje',
      readOnly: true,
      controller: context.read<ManifiestoCubit>().fechaViajeController,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          context.read<ManifiestoCubit>().fechaViajeChanged(pickedDate);
        }
      },
      validator: (value) {
        final fechaViaje = context.read<ManifiestoCubit>().state.fechaViaje;
        return fechaViaje.isNotValid ? fechaViaje.error : null;
      },
    );
  }
}

// Widget para Placa Vehicular
class _PlacaVehicularInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Placa Vehicular',
      controller: context.read<ManifiestoCubit>().placaVehicularController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().placaVehicularChanged(value);
      },
      validator: (value) {
        final placaVehicular = context.read<ManifiestoCubit>().state.placaVehicular;
        return placaVehicular.isNotValid ? placaVehicular.error : null;
      },
    );
  }
}

// Widget para Ruta
class _RutaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Ruta',
      controller: context.read<ManifiestoCubit>().rutaController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().rutaChanged(value);
      },
      validator: (value) {
        final ruta = context.read<ManifiestoCubit>().state.ruta;
        return ruta.isNotValid ? ruta.error : null;
      },
    );
  }
}

// Widget para Modalidad de Servicio
class _ModalidadServicioInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Modalidad de Servicio',
      controller: context.read<ManifiestoCubit>().modalidadServicioController,
      onChanged: (value) {
        context.read<ManifiestoCubit>().modalidadServicioChanged(value);
      },
      validator: (value) {
        final modalidadServicio = context.read<ManifiestoCubit>().state.modalidadServicio;
        return modalidadServicio.isNotValid ? modalidadServicio.error : null;
      },
    );
  }
}

class _PasajeroInput extends StatelessWidget {
  const _PasajeroInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: ThemeColors.secondaryBlue.withOpacity(.05),
        border: Border.all(color: ThemeColors.secondaryBlue.withOpacity(.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        children: [_NombrePasajeroInput(), _DocumentoIdentidadInput(), _EdadPasajeroInput(), SizedBox(height: 10)],
      ),
    );
  }
}

class _NombrePasajeroInput extends StatelessWidget {
  const _NombrePasajeroInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManifiestoCubit, ManifiestoFormState>(
      builder: (context, state) {
        return TextField(
          controller: context.read<ManifiestoCubit>().nombrePasajeroController,
          decoration: const InputDecoration(
            labelText: 'Nombre del Pasajero ',
          ),
        );
      },
    );
  }
}

class _DocumentoIdentidadInput extends StatelessWidget {
  const _DocumentoIdentidadInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManifiestoCubit, ManifiestoFormState>(
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(
            labelText: 'Documento de Identidad del Pasajero',
          ),
          controller: context.read<ManifiestoCubit>().documentoIdentidadPasajeroController,
        );
      },
    );
  }
}

class _EdadPasajeroInput extends StatelessWidget {
  const _EdadPasajeroInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManifiestoCubit, ManifiestoFormState>(
      builder: (context, state) {
        return TextField(
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: const InputDecoration(labelText: 'Edad del pasajero:'),
          controller: context.read<ManifiestoCubit>().edadPasajeroController,
        );
      },
    );
  }
}
