import 'package:app_remision/core/constants/paths.dart';
import 'package:app_remision/core/helpers/signature/form_functions.dart';
import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/auth/loading_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/form/cubit/pesos_medidas_form_cubit.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:app_remision/presentation/shared/widgets/custom_divider.dart';
import 'package:app_remision/presentation/shared/widgets/custom_signature_check.dart';
import 'package:app_remision/presentation/shared/widgets/custom_text_field.dart';
import 'package:app_remision/core/helpers/signature/cubit/signature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';

class PesosMedidasFormScreen extends StatelessWidget {
  final VerificacionPesosMedidasModel? verificacionModel;
  static const path = '/pesos-medidas';
  const PesosMedidasFormScreen({super.key, this.verificacionModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Verificación'),
      ),
      body: BlocProvider(
        create: (context) => PesosMedidasFormCubit(
            context.read<VerificacionPesosMedidasRepository>(), context.read<LocalFormsRepository>())
          ..initEditForm(verificacionModel)
          ..fechaChanged(DateTime.now()),
        child: PesosMedidasView(verificacionModel: verificacionModel),
      ),
    );
  }
}

class PesosMedidasView extends StatelessWidget {
  final VerificacionPesosMedidasModel? verificacionModel;

  const PesosMedidasView({
    super.key,
    this.verificacionModel,
  });

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<AuthCubit>();
    final pesosMedidasCubit = context.read<PesosMedidasFormCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocListener<SignatureCubit, SignatureCState>(
        listener: (context, state) {
          if (state.status == SignatureStatus.loading) CustomDialogs.loadingDialog(context);
          if (state.status == SignatureStatus.success) {
            context.pop();
            userCubit.checkAuthentication();
            pesosMedidasCubit.setSignatureUrl(state.urlImage ?? '');
          }
        },
        child: BlocConsumer<PesosMedidasFormCubit, PesosMedidasFormState>(
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.inProgress) {
              CustomDialogs.loadingDialog(context);
            }
            if (state.status == FormzSubmissionStatus.failure) {
              context.pop();
              CustomDialogs.errorDialog(context, state.message);
            }
            if (state.status == FormzSubmissionStatus.success) {
              context.pop();
              CustomDialogs.successDialog(
                  context: context,
                  successMessage: 'Se ha creado el documento exitosamente.',
                  onPressed: () {
                    context.pushReplacement(LoadingScreen.path);
                  });
            }
          },
          builder: (context, state) {
            final signatureUrl = state.signatureUrl;
            final signatureCubit = context.read<SignatureCubit>();

            return SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  children: [
                    const _FechaInput(),
                    const SizedBox(height: 16),
                    const _RegistroInput(),
                    const SizedBox(height: 16),
                    CustomNamedDivider(
                      label: 'Datos del Generador de la Carga',
                      fontSize: 18,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .5,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          children: [
                            InteractiveViewer(
                                boundaryMargin: const EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.ejemploVerificacion1)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const _EmpresaInput(),
                    const SizedBox(height: 16),
                    const _RUCInput(),
                    const SizedBox(height: 16),
                    const _NombreRepresentante(),
                    const SizedBox(height: 16),
                    const _DniInput(),
                    const SizedBox(height: 16),
                    const _TelefonoInput(),
                    const SizedBox(height: 16),
                    const _DireccionInput(),
                    const _DepartamentoInput(),
                    const SizedBox(height: 16),
                    const _ProvinciaInput(),
                    const SizedBox(height: 16),
                    const _DistritoInput(),
                    const SizedBox(height: 16),
                    CustomNamedDivider(
                      label: 'Tipo de Mercancía Transportada',
                      fontSize: 18,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .5,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InteractiveViewer(
                                boundaryMargin: const EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.ejemploVerificacion2)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const Align(alignment: Alignment.centerLeft, child: Text('Según Guía de Remisión que se Adjunta:')),
                    const SizedBox(height: 8),
                    (state.guias != null && state.guias!.isNotEmpty)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                      state.guias?.length ?? 0,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                    child: Icon(Icons.delete, size: 25, color: Colors.red.shade300),
                                                    onTap: () =>
                                                        context.read<PesosMedidasFormCubit>().deleteGuia(index)),
                                                const SizedBox(width: 20),
                                                Text("Guía - ${state.guias?[index]}",
                                                    style: const TextStyle(
                                                        fontSize: 18, color: ThemeColors.secondaryBlue)),
                                              ],
                                            ),
                                          ))
                                ]),
                          )
                        : const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('No hay guías registradas', style: TextStyle(fontSize: 18))),
                    const SizedBox(height: 16),
                    const _NumeroDeGuia(),
                    const Text('Por favor escriba el numero de guía y de clic en Agregar',
                        style: TextStyle(fontSize: 12)),
                    TextButton(
                        onPressed: () {
                          if (context.read<PesosMedidasFormCubit>().numeroDeGuiaController.text != '') {
                            context.read<PesosMedidasFormCubit>().agregarGuia();
                          }
                        },
                        child: const Text('Agregar +')),
                    const _TipoControlInput(),
                    const SizedBox(height: 16),
                    CustomNamedDivider(
                      label: 'Datos del vehículo',
                      fontSize: 18,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .5,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InteractiveViewer(
                                boundaryMargin: const EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.ejemploVerificacion3)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const _Placas1Input(),
                    const SizedBox(height: 16),
                    const _Placas2Input(),
                    const SizedBox(height: 16),
                    const _Placas3Input(),
                    const SizedBox(height: 16),
                    const _DimensionVehiculoInput(),
                    const SizedBox(height: 16),
                    const _ConfiguracionVehicularInput(),
                    const SizedBox(height: 16),
                    const _PesoBrutoMaxPermitidoInput(),
                    const SizedBox(height: 16),
                    const _PesoBrutoTotalTransportadoInput(),
                    const SizedBox(height: 16),
                    const _PBMaxEjesInput(),
                    const SizedBox(height: 16),
                    const _PBMaxBonificacionesInput(),
                    const SizedBox(height: 16),
                    CustomNamedDivider(
                      label: 'Control de Pesos y Ejes',
                      fontSize: 18,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .5,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InteractiveViewer(
                                boundaryMargin: const EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.ejemploVerificacion4)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const Text('Para aquellos vehículos que exceden el 95% de la suma de los pesos por ejes'),
                    const _DistribucionEjesInput(),
                    const SizedBox(height: 16),
                    const _ObservacionesInput(),
                    const SizedBox(height: 32),
                    if (signatureUrl != null && signatureUrl.isNotEmpty)
                      const CustomSignatureCheck()
                    else
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: ThemeColors.primaryRed)),
                        child: TextButton(
                          onPressed: () async {
                            final filePath = await showSignatureDialog(context);
                            if (filePath != null) {
                              signatureCubit.saveSignature(userCubit.state.userModel?.userId ?? '', filePath);

                              // context.read<PesosMedidasFormCubit>().setSignatureUrl(filePath);
                            }
                          },
                          child: const Text('Firmar Documento'),
                        ),
                      ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const SizedBox(width: 200, child: Text('Persona Jurídica ')),
                        Switch(
                            value: state.personaJuridica ?? false,
                            onChanged: (value) => context.read<PesosMedidasFormCubit>().personaJuridicaChanged())
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 200, child: Text('Persona Natural')),
                        Switch(
                            value: !state.personaJuridica!,
                            onChanged: (value) => context.read<PesosMedidasFormCubit>().personaJuridicaChanged())
                      ],
                    ),
                    _SubmitButton(verificacionModel),
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

class _FechaInput extends StatelessWidget {
  const _FechaInput();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          context.read<PesosMedidasFormCubit>().fechaChanged(pickedDate);
        }
      },
      child: BlocBuilder<PesosMedidasFormCubit, PesosMedidasFormState>(
        builder: (context, state) {
          return AbsorbPointer(
            child: CustomTextfield(
              labelText: 'Fecha',
              controller: TextEditingController(
                // ignore: unnecessary_null_comparison
                text: state.fecha != null ? DateFormat('dd/MM/yyyy').format(state.fecha.value ?? DateTime.now()) : '',
              ),
              validator: (value) {
                final fecha = context.read<PesosMedidasFormCubit>().state.fecha;
                return fecha.isNotValid ? fecha.error : null;
              },
            ),
          );
        },
      ),
    );
  }
}

class _RegistroInput extends StatelessWidget {
  const _RegistroInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Numero de registro',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<PesosMedidasFormCubit>().registroController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().registroChanged(value);
      },
      validator: (value) {
        final numeroRegistro = context.read<PesosMedidasFormCubit>().state.registro;
        return numeroRegistro.isNotValid ? numeroRegistro.error : null;
      },
    );
  }
}

class _DniInput extends StatelessWidget {
  const _DniInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Número de DNI',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<PesosMedidasFormCubit>().dniController,
      // onChanged: (value) {
      //   context.read<PesosMedidasFormCubit>().registroChanged(value);
      // },
      // validator: (value) {
      //   final numeroRegistro = context.read<PesosMedidasFormCubit>().state.registro;
      //   return numeroRegistro.isNotValid ? numeroRegistro.error : null;
      // },
    );
  }
}

class _EmpresaInput extends StatelessWidget {
  const _EmpresaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Nombre de la Empresa',
      controller: context.read<PesosMedidasFormCubit>().nombreEmpresaController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().nombreEmpresaChanged(value);
      },
      validator: (value) {
        final nombreEmpresa = context.read<PesosMedidasFormCubit>().state.nombreEmpresa;
        return nombreEmpresa.isNotValid ? nombreEmpresa.error : null;
      },
    );
  }
}

class _NombreRepresentante extends StatelessWidget {
  const _NombreRepresentante();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Nombre del Representante',
      controller: context.read<PesosMedidasFormCubit>().nombreRepresentanteController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().nombreRepresentanteChanged(value);
      },
      validator: (value) {
        final nombreEmpresa = context.read<PesosMedidasFormCubit>().state.nombreEmpresa;
        return nombreEmpresa.isNotValid ? nombreEmpresa.error : null;
      },
    );
  }
}

class _RUCInput extends StatelessWidget {
  const _RUCInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'N° RUC',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<PesosMedidasFormCubit>().rucController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().rucChanged(value);
      },
      validator: (value) {
        final ruc = context.read<PesosMedidasFormCubit>().state.ruc;
        return ruc.isNotValid ? ruc.error : null;
      },
    );
  }
}

class _TelefonoInput extends StatelessWidget {
  const _TelefonoInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Teléfono',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<PesosMedidasFormCubit>().telefonoController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().telefonoChanged(value);
      },
    );
  }
}

class _DireccionInput extends StatelessWidget {
  const _DireccionInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Dirección',
      controller: context.read<PesosMedidasFormCubit>().direccionController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().direccionChanged(value);
      },
      validator: (value) {
        final direccion = context.read<PesosMedidasFormCubit>().state.direccion;
        return direccion.isNotValid ? direccion.error : null;
      },
    );
  }
}

class _DistritoInput extends StatelessWidget {
  const _DistritoInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Distrito',
      controller: context.read<PesosMedidasFormCubit>().distritoController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().distritoChanged(value);
      },
      validator: (value) {
        final distrito = context.read<PesosMedidasFormCubit>().state.distrito;
        return distrito.isNotValid ? distrito.error : null;
      },
    );
  }
}

class _ProvinciaInput extends StatelessWidget {
  const _ProvinciaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Provincia',
      controller: context.read<PesosMedidasFormCubit>().provinciaController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().provinciaChanged(value);
      },
      validator: (value) {
        final provincia = context.read<PesosMedidasFormCubit>().state.provincia;
        return provincia.isNotValid ? provincia.error : null;
      },
    );
  }
}

class _DepartamentoInput extends StatelessWidget {
  const _DepartamentoInput();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PesosMedidasFormCubit>();
    final departamentos = [
      'Amazonas',
      'Ancash',
      'Apurimac',
      'Arequipa',
      'Ayacucho',
      'Cajamarca',
      'Callao',
      'Cusco',
      'Huancavelica',
      'Huanuco',
      'Ica',
      'Junín',
      'La Libertad',
      'Lambayeque',
      'Lima',
      'Loreto',
      'Madre de Dios',
      'Moquegua',
      'Pasco',
      'Piura',
      'Puno',
      'San Martín',
      'Tacna',
      'Tumbes',
      'Ucayali',
      '---'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: cubit.state.departamento.value.isEmpty ? '---' : cubit.state.departamento.value,
          items: departamentos.map((String departamento) {
            return DropdownMenuItem<String>(
              value: departamento,
              child: Text(departamento),
            );
          }).toList(),
          onChanged: (value) {
            cubit.departamentoChanged(value ?? '');
          },
          validator: (_) {
            final departamento = cubit.state.departamento;
            return departamento.isNotValid ? departamento.error : null;
          },
          decoration: const InputDecoration(
            labelText: 'Departamento',
            border: UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class _TipoControlInput extends StatelessWidget {
  const _TipoControlInput();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Tipo de Control Efectuado',
        border: UnderlineInputBorder(),
      ),
      value: context.read<PesosMedidasFormCubit>().tipoControlController.text != ''
          ? context.read<PesosMedidasFormCubit>().tipoControlController.text
          : '---',
      items: const [
        DropdownMenuItem(value: '---', child: Text('---')),
        DropdownMenuItem(value: 'balanza', child: Text('Balanza')),
        DropdownMenuItem(value: 'software', child: Text('Software')),
        DropdownMenuItem(value: 'cubicacion', child: Text('Cubicación')),
        DropdownMenuItem(value: 'otros', child: Text('Otros')),
      ],
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().tipoControlChanged(value!);
      },
    );
  }
}

class _NumeroDeGuia extends StatelessWidget {
  const _NumeroDeGuia();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
        labelText: 'Numero de Guias',
        keyboardType: TextInputType.visiblePassword,
        controller: context.read<PesosMedidasFormCubit>().numeroDeGuiaController);
  }
}

class _Placas1Input extends StatelessWidget {
  const _Placas1Input();
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
        labelText: 'Placas 1 (camión, tracto, remolque, etc.)',
        controller: context.read<PesosMedidasFormCubit>().placas1TextController);
  }
}

class _Placas2Input extends StatelessWidget {
  const _Placas2Input();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Placas 2 (camión, tracto, remolque, etc.)',
      controller: context.read<PesosMedidasFormCubit>().placas2TextController,
    );
  }
}

class _Placas3Input extends StatelessWidget {
  const _Placas3Input();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Placas 3 (camión, tracto, remolque, etc.)',
      controller: context.read<PesosMedidasFormCubit>().placas3TextController,
    );
  }
}

class _DimensionVehiculoInput extends StatelessWidget {
  const _DimensionVehiculoInput();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomTextfield(
              labelText: 'Largo (mt)',
              onChanged: (value) {
                context.read<PesosMedidasFormCubit>().largoChanged(value);
              },
              keyboardType: const TextInputType.numberWithOptions(),
              controller: context.read<PesosMedidasFormCubit>().largoController,
              validator: (value) {
                final largo = context.read<PesosMedidasFormCubit>().state.largo;
                return largo.isNotValid ? largo.error : null;
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomTextfield(
              labelText: 'Ancho (mt)',
              keyboardType: const TextInputType.numberWithOptions(),
              controller: context.read<PesosMedidasFormCubit>().anchoController,
              onChanged: (value) {
                context.read<PesosMedidasFormCubit>().anchoChanged(value);
              },
              validator: (value) {
                final ancho = context.read<PesosMedidasFormCubit>().state.ancho;
                return ancho.isNotValid ? ancho.error : null;
              },
            ),
          ),
        ),
        Expanded(
          child: CustomTextfield(
            labelText: 'Alto (mt)',
            keyboardType: const TextInputType.numberWithOptions(),
            onChanged: (value) {
              context.read<PesosMedidasFormCubit>().altoChanged(value);
            },
            controller: context.read<PesosMedidasFormCubit>().altoController,
            validator: (value) {
              final alto = context.read<PesosMedidasFormCubit>().state.alto;
              return alto.isNotValid ? alto.error : null;
            },
          ),
        ),
      ],
    );
  }
}

class _DistribucionEjesInput extends StatelessWidget {
  const _DistribucionEjesInput();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextfield(
                  labelText: 'CJTO 1 (Kg)',
                  controller: context.read<PesosMedidasFormCubit>().cjto1Controller,
                  onChanged: (value) {
                    context.read<PesosMedidasFormCubit>().cjto1Changed(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextfield(
                  labelText: 'CJTO 2 (Kg)',
                  controller: context.read<PesosMedidasFormCubit>().cjto2Controller,
                  onChanged: (value) {
                    context.read<PesosMedidasFormCubit>().cjto2Changed(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextfield(
                  labelText: 'CJTO 3 (Kg)',
                  controller: context.read<PesosMedidasFormCubit>().cjto3Controller,
                  onChanged: (value) {
                    context.read<PesosMedidasFormCubit>().cjto3Changed(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextfield(
                  labelText: 'CJTO 4 (Kg)',
                  controller: context.read<PesosMedidasFormCubit>().cjto4Controller,
                  onChanged: (value) {
                    context.read<PesosMedidasFormCubit>().cjto4Changed(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextfield(
                  labelText: 'CJTO 5 (Kg)',
                  onChanged: (value) {
                    context.read<PesosMedidasFormCubit>().cjto5Changed(value);
                  },
                  controller: context.read<PesosMedidasFormCubit>().cjto5Controller,
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CustomTextfield(
                  labelText: 'CJTO 6 (Kg)',
                  controller: context.read<PesosMedidasFormCubit>().cjto6Controller,
                  onChanged: (value) {
                    context.read<PesosMedidasFormCubit>().cjto6Changed(value);
                  },
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ConfiguracionVehicularInput extends StatefulWidget {
  const _ConfiguracionVehicularInput();

  @override
  State<_ConfiguracionVehicularInput> createState() => _ConfiguracionVehicularInputState();
}

class _ConfiguracionVehicularInputState extends State<_ConfiguracionVehicularInput> {
  final _pdfController = PdfController(
    document: PdfDocument.openAsset(paths.configuracionesPdf),
  );
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PesosMedidasFormCubit>();
    final configuracionesVehiculares = [
      'C2',
      'C2RB1',
      'C2RB2',
      'C2R2',
      'C3',
      'C3R2',
      'C3R3',
      'C3R4',
      'C3RB1',
      'C3RB2',
      'C4',
      'C4 RB1',
      'C4 RB2',
      'C4 R2',
      'C4 R3',
      '8x4',
      '8x4 RB1',
      '8x4 RB2',
      '8x4 R2',
      '8x4 R3',
      '8x4 R4',
      'T2S1',
      'T2S2',
      'T2 Se2',
      'T2S3',
      'T2 Se3',
      'T3 S1',
      'T3S2',
      'T3Se2',
      'T3S3',
      'T3Se3',
      '---'
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Configuración Vehicular'),
              DropdownButtonFormField<String>(
                value:
                    cubit.state.configuracionVehicular.value.isEmpty ? '---' : cubit.state.configuracionVehicular.value,
                items: configuracionesVehiculares.map((String configuracion) {
                  return DropdownMenuItem<String>(
                    value: configuracion,
                    child: Text(configuracion),
                  );
                }).toList(),
                onChanged: (value) {
                  cubit.configuracionVehicularChanged(value ?? '');
                },
                validator: (_) {
                  final configuracion = cubit.state.configuracionVehicular;
                  return configuracion.isNotValid ? configuracion.error : null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () => CustomDialogs.customWidgetDialog(
                  height: MediaQuery.sizeOf(context).height * .78,
                  context: context,
                  title: 'Guía para Configuración Vehícular: ',
                  childWidget: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * .66, child: PdfView(controller: _pdfController)),
                      ElevatedButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                    ],
                  ),
                ),
            icon: const Icon(Icons.help))
      ],
    );
  }
}

class _PesoBrutoMaxPermitidoInput extends StatelessWidget {
  const _PesoBrutoMaxPermitidoInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Peso Bruto Vehicular Máx. Permitido (Kg)',
      keyboardType: const TextInputType.numberWithOptions(),
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().pesoBrutoMaximoChanged(value);
      },
      controller: context.read<PesosMedidasFormCubit>().pesoBrutoMaximoController,
      validator: (value) {
        final pesoBrutoMaximo = context.read<PesosMedidasFormCubit>().state.pesoBrutoMaximo;
        return pesoBrutoMaximo.isNotValid ? pesoBrutoMaximo.error : null;
      },
    );
  }
}

class _PesoBrutoTotalTransportadoInput extends StatelessWidget {
  const _PesoBrutoTotalTransportadoInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Peso Bruto Total Transportado (Kg)',
      keyboardType: const TextInputType.numberWithOptions(),
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().pesoTransportadoChanged(value);
      },
      controller: context.read<PesosMedidasFormCubit>().pesoTransportadoController,
      validator: (value) {
        final pesoTransportado = context.read<PesosMedidasFormCubit>().state.pesoTransportado;
        return pesoTransportado.isNotValid ? pesoTransportado.error : null;
      },
    );
  }
}

class _PBMaxEjesInput extends StatelessWidget {
  const _PBMaxEjesInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
        labelText: 'PBMax. para no control de pesos por ejes (Kg)',
        keyboardType: const TextInputType.numberWithOptions(),
        controller: context.read<PesosMedidasFormCubit>().pbMaxNoControlController,
        onChanged: (value) {
          context.read<PesosMedidasFormCubit>().pbMaxNoControlChanged(value);
        });
  }
}

class _PBMaxBonificacionesInput extends StatelessWidget {
  const _PBMaxBonificacionesInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'PBMax. con Bonificaciones (Kg)',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<PesosMedidasFormCubit>().pbMaxConBonificacionController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().pbMaxConBonificacionChanged(value);
      },
      // validator: (value) {
      //   final pbMaxConBonificacion = context.read<PesosMedidasFormCubit>().state.pbMaxConBonificacion;
      //   return pbMaxConBonificacion.isNotValid ? pbMaxConBonificacion.error : null;
      // },
    );
  }
}

class _ObservacionesInput extends StatelessWidget {
  const _ObservacionesInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Observaciones',
      controller: context.read<PesosMedidasFormCubit>().observacionesController,
      onChanged: (value) {
        context.read<PesosMedidasFormCubit>().observacionesChanged(value);
      },
      // validator: (value) {
      //   final observaciones = context.read<PesosMedidasFormCubit>().state.observaciones;
      //   return observaciones.isNotValid ? observaciones.error : null;
      // },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final VerificacionPesosMedidasModel? verificacionModel;

  const _SubmitButton(this.verificacionModel);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PesosMedidasFormCubit, PesosMedidasFormState>(
      builder: (context, state) {
        if (verificacionModel == null) {
          return ElevatedButton(
            onPressed: () {
              state.isValidate
                  ? context.read<PesosMedidasFormCubit>().submitForm(
                      context.read<AuthCubit>().state.userModel?.userId ?? '',
                      context.read<AuthCubit>().state.userModel?.logoUrl ?? '')
                  : CustomDialogs.errorDialog(context, 'Hay Campos obligatorios sin Llenar');
            },
            child: const Text('Enviar'),
          );
        } else {
          return ElevatedButton(
              onPressed: () {
                state.isValidate
                    ? context.read<PesosMedidasFormCubit>().editForm(verificacionModel!)
                    : CustomDialogs.errorDialog(context, 'Hay Campos obligatorios sin Llenar');
              },
              child: const Text('Editar y Guardar'));
        }
      },
    );
  }
}
