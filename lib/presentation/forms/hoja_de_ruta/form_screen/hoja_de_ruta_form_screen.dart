import 'package:app_remision/core/constants/paths.dart';
import 'package:app_remision/core/constants/texts.dart';
import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:app_remision/presentation/shared/widgets/custom_divider.dart';
import 'package:app_remision/presentation/shared/widgets/custom_text_field.dart';
import 'package:app_remision/core/helpers/signature/cubit/signature_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'cubit/hoja_de_ruta_cubit.dart';

class HojaDeRutaFormScreen extends StatelessWidget {
  final HojaDeRutaModel? hojaDeRutaModel;
  const HojaDeRutaFormScreen({super.key, this.hojaDeRutaModel});

  static const path = '/hoja-de-ruta';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HojaDeRutaCubit(context.read<HojaDeRutaRepository>(), context.read<LocalFormsRepository>())
        ..initEditForm(hojaDeRutaModel),
      child: HojaDeRutaFormView(
        hojaDeRutaModel: hojaDeRutaModel,
      ),
    );
  }
}

class HojaDeRutaFormView extends StatelessWidget {
  final HojaDeRutaModel? hojaDeRutaModel;

  const HojaDeRutaFormView({super.key, this.hojaDeRutaModel});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<AuthCubit>();
    final hojaDeRutaCubit = context.read<HojaDeRutaCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Hoja de Ruta'),
      ),
      body: BlocListener<SignatureCubit, SignatureCState>(
        listener: (context, state) {
          if (state.status == SignatureStatus.loading) CustomDialogs.loadingDialog(context);
          if (state.status == SignatureStatus.success) {
            context.pop();
            userCubit.checkAuthentication();
            hojaDeRutaCubit.setSignatureUrl(state.urlImage ?? '');
          }
        },
        child: BlocConsumer<HojaDeRutaCubit, HojaDeRutaFormState>(
          listenWhen: (previous, current) => current.status != previous.status,
          listener: (context, state) {
            if (state.status.isInProgress) {
              CustomDialogs.loadingDialog(context);
            } else if (state.status.isSuccess) {
              context.pop();
              CustomDialogs.successDialog(
                  context: context,
                  successMessage: 'Se ha creado la Hoja de Ruta exitosamente.',
                  onPressed: () => context.pushReplacement(HomeScreen.path));
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
                    const _FolioInput(),
                    const _RazonSocialInput(),
                    const _RucInput(),
                    const _DireccionInput(),
                    CustomNamedDivider(
                      label: texts.datosViaje,
                      fontSize: 14,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .6,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          children: [
                            InteractiveViewer(
                                boundaryMargin: EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.hr1)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const _ModalidadInput(),
                    const _NumPasajerosInput(),
                    CustomNamedDivider(label: texts.origen, fontSize: 11),
                    const _DepartamentoOrigenInput(),
                    const _ProvinciaOrigenInput(),
                    const _DistritoOrigenInput(),
                    const _DireccionOrigenInput(),
                    const _TerminalSalidaInput(),
                    _FechaInicioViajeInput(),
                    _HoraSalidaInput(),
                    CustomNamedDivider(label: texts.destino, fontSize: 11),

                    const _DepartamentoDestinoInput(),
                    const _ProvinciaDestinoInput(),
                    const _DistritoDestinoInput(),
                    const _DireccionDestinoInput(),
                    const _TerminalLlegadaInput(),
                    _FechaLlegadaViajeInput(),
                    _HoraLlegadaInput(),
                    CustomNamedDivider(
                      label: texts.datosItinerario,
                      fontSize: 14,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .6,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          children: [
                            InteractiveViewer(
                                boundaryMargin: EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.hr2)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const Text('Agregue un intinerario, una vez que haya terminado, presione Agregar Itinerario +'),
                    ...List.generate(
                      state.itinerarioList.length,
                      (index) => ItinerarioCard(
                        itinerario: state.itinerarioList[index],
                        onDelete: () => context.read<HojaDeRutaCubit>().deleteItinerario(index),
                      ),
                    ),
                    const _ItinerarioInput(),
                    TextButton(
                        onPressed: () => context.read<HojaDeRutaCubit>().agregarItinerario(),
                        child: const Text(
                          'Agregar Itinerario',
                          style: TextStyle(color: ThemeColors.secondaryBlue),
                        )),

                    CustomNamedDivider(
                      label: texts.datosConductor,
                      fontSize: 14,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .6,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          children: [
                            InteractiveViewer(
                                boundaryMargin: EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.hr3)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const Text('Agregue un Conductor, una vez que haya terminado, presione Agregar Conductor +'),

                    ...List.generate(
                      state.conductores.length,
                      (index) => ConductorCard(
                        conductor: state.conductores[index],
                        onDelete: () => context.read<HojaDeRutaCubit>().deleteConductor(index),
                      ),
                    ),
                    const _ConductorInput(),
                    TextButton(
                        onPressed: () => context.read<HojaDeRutaCubit>().agregarConductor(),
                        child: const Text('Agregar Conductor', style: TextStyle(color: ThemeColors.secondaryBlue))),
                    CustomNamedDivider(
                      label: texts.datosVehiculo,
                      fontSize: 14,
                      icon: Icons.help,
                      onIconTap: () => CustomDialogs.customWidgetDialog(
                        height: MediaQuery.sizeOf(context).height * .6,
                        context: context,
                        title: 'La sección corresponde a: ',
                        childWidget: Column(
                          children: [
                            InteractiveViewer(
                                boundaryMargin: EdgeInsets.all(20.0),
                                minScale: 0.5, // Mínimo de zoom
                                maxScale: 4.0, // Máximo de zoom
                                child: Image.asset(paths.hr4)),
                            TextButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
                          ],
                        ),
                      ),
                    ),
                    const _NumeroPlacaInput(),
                    const _EstadoInput(),
                    const _RevisionTecnicaInput(),
                    const _SOATInput(),
                    const CustomNamedDivider(label: 'Datos Complementarios', fontSize: 14),
                    const _TelefonoInput(),
                    const _CorreoElectronicoInput(),
                    const _RutaInput(),
                    // if (signatureUrl != null && signatureUrl.isNotEmpty)
                    //   const CustomSignatureCheck()
                    // else
                    //   Container(
                    //     decoration: BoxDecoration(border: Border.all(color: ThemeColors.primaryRed)),
                    //     child: TextButton(
                    //       onPressed: () async {
                    //         if (userCubit.state.userModel?.signatureUrl != null &&
                    //             userCubit.state.userModel!.signatureUrl!.isNotEmpty) {
                    //           hojaDeRutaCubit.setSignatureUrl(userCubit.state.userModel?.signatureUrl ?? '----');
                    //         } else {
                    //           final filePath = await showSignatureDialog(context);
                    //           if (filePath != null) {
                    //             signatureCubit.saveSignature(userCubit.state.userModel?.userId ?? '', filePath);
                    //           }
                    //         }
                    //       },
                    //       child: const Text('Firmar Documento'),
                    //     ),
                    //   ),
                    // const SizedBox(height: 15),
                    (hojaDeRutaModel != null)
                        ? ElevatedButton(
                            onPressed: () => context.read<HojaDeRutaCubit>().editForm(hojaDeRutaModel!),
                            child: const Text('Editar y Guardar'),
                          )
                        : ElevatedButton(
                            onPressed: () => context
                                .read<HojaDeRutaCubit>()
                                .submitForm(context.read<AuthCubit>().state.userModel?.userId ?? ''),
                            child: const Text('Enviar'),
                          ),
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

//!
class _ConductorInput extends StatelessWidget {
  const _ConductorInput();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('Nuevo Conductor'),
          SizedBox(height: 10),
          _NombreConductorInput(),
          _LicenciaConducirInput(),
          _TurnoConduccionInput(),
          _DescripcionIncidenciaInput(),
          _LugarIncidenciaInput(),
          SizedBox(height: 10),
          _HoraInicioConduccionInput(),
          _HoraFinConduccionInput(),
          _FechaHoraIncidenciaInput(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _FolioInput extends StatelessWidget {
  const _FolioInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Número de folio/id',
      keyboardType: const TextInputType.numberWithOptions(),
      controller: context.read<HojaDeRutaCubit>().folioController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().folioChanged(value);
      },
      validator: (value) {
        final folio = context.read<HojaDeRutaCubit>().state.folio;
        return folio.isNotValid ? folio.error : null;
      },
    );
  }
}

class _RazonSocialInput extends StatelessWidget {
  const _RazonSocialInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Razón Social',
      controller: context.read<HojaDeRutaCubit>().razonSocialController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().razonSocialChanged(value);
      },
      validator: (value) {
        final razonSocial = context.read<HojaDeRutaCubit>().state.razonSocial;
        return razonSocial.isNotValid ? razonSocial.error : null;
      },
    );
  }
}

class _CorreoElectronicoInput extends StatelessWidget {
  const _CorreoElectronicoInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Correo Electrónico',
      controller: context.read<HojaDeRutaCubit>().correoElectronicoController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().correoElectronicoChanged(value);
      },
      validator: (value) {
        final correoElectronico = context.read<HojaDeRutaCubit>().state.correoElectronico;
        return correoElectronico.isNotValid ? correoElectronico.error : null;
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
      controller: context.read<HojaDeRutaCubit>().telefonoController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().telefonoChanged(value);
      },
      // validator: (value) {
      //   final telefono = context.read<HojaDeRutaCubit>().state.telefono;
      //   return telefono.isNotValid ? telefono.error : null;
      // },
    );
  }
}

class _NumeroPlacaInput extends StatelessWidget {
  const _NumeroPlacaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Número de Placa',
      controller: context.read<HojaDeRutaCubit>().numeroPlacaController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().placasChanged(value);
      },
      validator: (value) {
        final numeroPlaca = context.read<HojaDeRutaCubit>().state.numeroPlaca;
        return numeroPlaca.isNotValid ? numeroPlaca.error : null;
      },
    );
  }
}

class _RutaInput extends StatelessWidget {
  const _RutaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Ruta',
      controller: context.read<HojaDeRutaCubit>().rutaController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().rutaChanged(value);
      },
      // validator: (value) {
      //   final ruta = context.read<HojaDeRutaCubit>().state.ruta;
      //   return ruta.isNotValid ? ruta.error : null;
      // },
    );
  }
}

class _TerminalSalidaInput extends StatelessWidget {
  const _TerminalSalidaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Terminal de Salida',
      controller: context.read<HojaDeRutaCubit>().terminalSalidaController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().terminalSalidaChanged(value);
      },
      validator: (value) {
        final terminalSalida = context.read<HojaDeRutaCubit>().state.terminalSalida;
        return terminalSalida.isNotValid ? terminalSalida.error : null;
      },
    );
  }
}

class _TerminalLlegadaInput extends StatelessWidget {
  const _TerminalLlegadaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Terminal de Llegada',
      controller: context.read<HojaDeRutaCubit>().terminalLlegadaController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().terminalLlegadaChanged(value);
      },
      validator: (value) {
        final terminalLlegada = context.read<HojaDeRutaCubit>().state.terminalLlegada;
        return terminalLlegada.isNotValid ? terminalLlegada.error : null;
      },
    );
  }
}

class _ModalidadServicioInput extends StatelessWidget {
  const _ModalidadServicioInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Modalidad de Servicio',
      controller: context.read<HojaDeRutaCubit>().modalidadServicioController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().modalidadServicioChanged(value);
      },
      validator: (value) {
        final modalidadServicio = context.read<HojaDeRutaCubit>().state.modalidadServicio;
        return modalidadServicio.isNotValid ? modalidadServicio.error : null;
      },
    );
  }
}

class _ModalidadInput extends StatelessWidget {
  const _ModalidadInput();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Modalidad de Servicio',
        border: UnderlineInputBorder(),
      ),
      value: context.read<HojaDeRutaCubit>().modalidadServicioController.text != ''
          ? context.read<HojaDeRutaCubit>().modalidadServicioController.text
          : '---',
      items: const [
        DropdownMenuItem(value: '---', child: Text('---')),
        DropdownMenuItem(value: 'traslado', child: Text('traslado')),
        DropdownMenuItem(value: 'visita local', child: Text('visita local')),
        DropdownMenuItem(value: 'excursion', child: Text('excursion')),
        DropdownMenuItem(value: 'gira', child: Text('gira')),
        DropdownMenuItem(value: 'circuito', child: Text('circuito'))
      ],
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().modalidadServicioChanged(value!);
      },
    );
  }
}

class _LicenciaConducirInput extends StatelessWidget {
  const _LicenciaConducirInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Licencia de Conducir',
      controller: context.read<HojaDeRutaCubit>().licenciaConducirController,
    );
  }
}

class _NombreConductorInput extends StatelessWidget {
  const _NombreConductorInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: context.read<HojaDeRutaCubit>().nombreConductorController,
      labelText: 'Nombre del Conductor',
    );
  }
}

class _TurnoConduccionInput extends StatelessWidget {
  const _TurnoConduccionInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Turno de Conducción',
      controller: context.read<HojaDeRutaCubit>().turnoConduccionController,
    );
  }
}

class _DescripcionIncidenciaInput extends StatelessWidget {
  const _DescripcionIncidenciaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Descripción de Incidencia',
      controller: context.read<HojaDeRutaCubit>().descripcionIncidenciaController,
    );
  }
}

class _LugarIncidenciaInput extends StatelessWidget {
  const _LugarIncidenciaInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Lugar de Incidencia',
      controller: context.read<HojaDeRutaCubit>().lugarIncidenciaController,
    );
  }
}

//! --datetimes
class _FechaInicioViajeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Fecha de Inicio del Viaje',
      readOnly: true,
      controller: context.read<HojaDeRutaCubit>().fechaInicioViajeController,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          context.read<HojaDeRutaCubit>().fechaInicioViajeChanged(pickedDate);
        }
      },
      validator: (value) {
        final fechaInicioViaje = context.read<HojaDeRutaCubit>().state.fechaInicioViaje;
        return fechaInicioViaje.isNotValid ? fechaInicioViaje.error : null;
      },
    );
  }
}

class _FechaLlegadaViajeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Fecha de Llegada del Viaje',
      readOnly: true,
      controller: context.read<HojaDeRutaCubit>().fechaLlegadaViajeController,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          context.read<HojaDeRutaCubit>().fechaLlegadaViajeChanged(pickedDate);
        }
      },
      validator: (value) {
        final fechaLlegadaViaje = context.read<HojaDeRutaCubit>().state.fechaLlegadaViaje;
        return fechaLlegadaViaje.isNotValid ? fechaLlegadaViaje.error : null;
      },
    );
  }
}

class _HoraSalidaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Hora de Salida',
      readOnly: true,
      controller: context.read<HojaDeRutaCubit>().horaSalidaController,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          final now = DateTime.now();
          final fullDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
          context.read<HojaDeRutaCubit>().horaSalidaChanged(fullDateTime);
        }
      },
      validator: (value) {
        final horaSalida = context.read<HojaDeRutaCubit>().state.horaSalida;
        return horaSalida.isNotValid ? horaSalida.error : null;
      },
    );
  }
}

class _HoraLlegadaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Hora de Llegada',
      readOnly: true,
      controller: context.read<HojaDeRutaCubit>().horaLlegadaController,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          final now = DateTime.now();
          final fullDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
          context.read<HojaDeRutaCubit>().horaLlegadaChanged(fullDateTime);
        }
      },
      validator: (value) {
        final horaLlegada = context.read<HojaDeRutaCubit>().state.horaLlegada;
        return horaLlegada.isNotValid ? horaLlegada.error : null;
      },
    );
  }
}

class _HoraInicioConduccionInput extends StatelessWidget {
  const _HoraInicioConduccionInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              final now = DateTime.now();
              final fullDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
              context.read<HojaDeRutaCubit>().horaInicioConduccionChanged(fullDateTime);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hora de Inicio de Conducción: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  state.horaInicio != null
                      ? DateFormat.jm().format(state.horaInicio ?? DateTime.now())
                      : 'Toque para seleccionar una hora',
                  style: const TextStyle(color: ThemeColors.secondaryBlue),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HoraFinConduccionInput extends StatelessWidget {
  const _HoraFinConduccionInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              final now = DateTime.now();
              final fullDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
              context.read<HojaDeRutaCubit>().horaFinConduccionChanged(fullDateTime);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hora de Fin de Conducción: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  state.horaTermino != null
                      ? DateFormat.jm().format(state.horaTermino ?? DateTime.now())
                      : 'Toque para seleccionar una hora',
                  style: const TextStyle(color: ThemeColors.secondaryBlue),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FechaHoraIncidenciaInput extends StatelessWidget {
  const _FechaHoraIncidenciaInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      builder: (context, state) {
        final hrc = context.read<HojaDeRutaCubit>();
        return GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                final fullDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                hrc.fechaHoraIncidenciaChanged(fullDateTime);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fecha y Hora de Incidencia: ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  state.fechaHoraIncidencia != null
                      ? DateFormat('yyyy-MM-dd – kk:mm').format(state.fechaHoraIncidencia ?? DateTime.now())
                      : 'Toque para seleccionar una fecha y hora',
                  style: const TextStyle(color: ThemeColors.secondaryBlue),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RucInput extends StatelessWidget {
  const _RucInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.rucField.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.rucField != current.rucField,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'RUC',
          keyboardType: const TextInputType.numberWithOptions(),
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().rucChanged(value);
          },
          validator: (value) {
            final ruc = context.read<HojaDeRutaCubit>().state.rucField;
            return ruc.isNotValid ? ruc.error : null;
          },
        );
      },
    );
  }
}

class _NumPasajerosInput extends StatelessWidget {
  const _NumPasajerosInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.numPasajeros.value.toString();

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.numPasajeros != current.numPasajeros,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Número de Pasajeros',
          keyboardType: const TextInputType.numberWithOptions(),
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().numPasajerosChanged(int.parse(value));
          },
          validator: (value) {
            final numPasajeros = context.read<HojaDeRutaCubit>().state.numPasajeros;
            return numPasajeros.isNotValid ? numPasajeros.error : null;
          },
        );
      },
    );
  }
}

class _DistritoOrigenInput extends StatelessWidget {
  const _DistritoOrigenInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.distritoOrigen.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.distritoOrigen != current.distritoOrigen,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Distrito origen',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().distritoOrigenChanged(value);
          },
          validator: (value) {
            final distrito = context.read<HojaDeRutaCubit>().state.distritoOrigen;
            return distrito.isNotValid ? distrito.error : null;
          },
        );
      },
    );
  }
}

class _ProvinciaOrigenInput extends StatelessWidget {
  const _ProvinciaOrigenInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.provinciaOrigen.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.provinciaOrigen != current.provinciaOrigen,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Provincia origen',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().provinciaOrigenChanged(value);
          },
          validator: (value) {
            final provinciaOrigen = context.read<HojaDeRutaCubit>().state.provinciaOrigen;
            return provinciaOrigen.isNotValid ? provinciaOrigen.error : null;
          },
        );
      },
    );
  }
}

class _DepartamentoOrigenInput extends StatelessWidget {
  const _DepartamentoOrigenInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.departamentoOrigen.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.departamentoOrigen != current.departamentoOrigen,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Departamento Origen',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().departamentoOrigenChanged(value);
          },
          validator: (value) {
            final departamentoOrigen = context.read<HojaDeRutaCubit>().state.departamentoOrigen;
            return departamentoOrigen.isNotValid ? departamentoOrigen.error : null;
          },
        );
      },
    );
  }
}

class _DistritoDestinoInput extends StatelessWidget {
  const _DistritoDestinoInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.distritoDestino.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.distritoDestino != current.distritoDestino,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Distrito Destino',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().distritoDestinoChanged(value);
          },
          validator: (value) {
            final distritoDestino = context.read<HojaDeRutaCubit>().state.distritoDestino;
            return distritoDestino.isNotValid ? distritoDestino.error : null;
          },
        );
      },
    );
  }
}

class _ProvinciaDestinoInput extends StatelessWidget {
  const _ProvinciaDestinoInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.provinciaDestino.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.provinciaDestino != current.provinciaDestino,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Provincia Destino',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().provinciaDestinoChanged(value);
          },
          validator: (value) {
            final provinciaDestino = context.read<HojaDeRutaCubit>().state.provinciaDestino;
            return provinciaDestino.isNotValid ? provinciaDestino.error : null;
          },
        );
      },
    );
  }
}

class _DepartamentoDestinoInput extends StatelessWidget {
  const _DepartamentoDestinoInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.departamentoDestino.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.departamentoDestino != current.departamentoDestino,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Departamento Destino',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().departamentoDestinoChanged(value);
          },
          validator: (value) {
            final departamentoDestino = context.read<HojaDeRutaCubit>().state.departamentoDestino;
            return departamentoDestino.isNotValid ? departamentoDestino.error : null;
          },
        );
      },
    );
  }
}

class _EstadoInput extends StatelessWidget {
  const _EstadoInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.estado.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.estado != current.estado,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Estado',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().estadoChanged(value);
          },
          validator: (value) {
            final estado = context.read<HojaDeRutaCubit>().state.estado;
            return estado.isNotValid ? estado.error : null;
          },
        );
      },
    );
  }
}

class _RevisionTecnicaInput extends StatelessWidget {
  const _RevisionTecnicaInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.revisionTecnica.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.revisionTecnica != current.revisionTecnica,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Revisión Técnica',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().revisionTecnicaChanged(value);
          },
          validator: (value) {
            final revisionTecnica = context.read<HojaDeRutaCubit>().state.revisionTecnica;
            return revisionTecnica.isNotValid ? revisionTecnica.error : null;
          },
        );
      },
    );
  }
}

class _DireccionInput extends StatelessWidget {
  const _DireccionInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.direccionOrigen != current.direccionOrigen,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Dirección',
          controller: context.read<HojaDeRutaCubit>().direccionController,
        );
      },
    );
  }
}

class _DireccionOrigenInput extends StatelessWidget {
  const _DireccionOrigenInput();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = context.read<HojaDeRutaCubit>().state.direccionOrigen.value;

    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.direccionOrigen != current.direccionOrigen,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Dirección Origen',
          controller: controller,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().direccionOrigenChanged(value);
          },
          validator: (value) {
            final direccionOrigen = context.read<HojaDeRutaCubit>().state.direccionOrigen;
            return direccionOrigen.isNotValid ? direccionOrigen.error : null;
          },
        );
      },
    );
  }
}

class _DireccionDestinoInput extends StatelessWidget {
  const _DireccionDestinoInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      labelText: 'Dirección Destino',
      controller: context.read<HojaDeRutaCubit>().direccionDestinoController,
      onChanged: (value) {
        context.read<HojaDeRutaCubit>().direccionDestinoChanged(value);
      },
      validator: (value) {
        final direccionDestino = context.read<HojaDeRutaCubit>().state.direccionDestino;
        return direccionDestino.isNotValid ? direccionDestino.error : null;
      },
    );
  }
}

class _SOATInput extends StatelessWidget {
  const _SOATInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      buildWhen: (previous, current) => previous.soat != current.soat,
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'SOAT',
          controller: context.read<HojaDeRutaCubit>().soatController,
          onChanged: (value) {
            context.read<HojaDeRutaCubit>().soatChanged(value);
          },
          validator: (value) {
            final soat = context.read<HojaDeRutaCubit>().state.soat;
            return soat.isNotValid ? soat.error : null;
          },
        );
      },
    );
  }
}

class _ItinerarioInput extends StatelessWidget {
  const _ItinerarioInput();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('Nuevo Itinerario'),
          SizedBox(height: 10),
          _DepartamentoItinerarioInput(),
          _ProvinciaItinerarioInput(),
          _DistritoItinerarioInput(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _DistritoItinerarioInput extends StatelessWidget {
  const _DistritoItinerarioInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Distrito',
          controller: context.read<HojaDeRutaCubit>().distritoItinerarioController,
        );
      },
    );
  }
}

class _ProvinciaItinerarioInput extends StatelessWidget {
  const _ProvinciaItinerarioInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Provincia',
          controller: context.read<HojaDeRutaCubit>().provinciaItinerarioController,
        );
      },
    );
  }
}

class _DepartamentoItinerarioInput extends StatelessWidget {
  const _DepartamentoItinerarioInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HojaDeRutaCubit, HojaDeRutaFormState>(
      builder: (context, state) {
        return CustomTextfield(
          labelText: 'Departamento',
          controller: context.read<HojaDeRutaCubit>().departamentoItinerarioController,
        );
      },
    );
  }
}

class ItinerarioCard extends StatelessWidget {
  final Itinerario itinerario;
  final VoidCallback onDelete;

  const ItinerarioCard({
    Key? key,
    required this.itinerario,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distrito: ${itinerario.distrito ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Provincia: ${itinerario.provincia ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Departamento: ${itinerario.departamento ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class ConductorCard extends StatelessWidget {
  final Conductor conductor;
  final VoidCallback onDelete;

  const ConductorCard({
    Key? key,
    required this.conductor,
    required this.onDelete,
  }) : super(key: key);

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    conductor.nombre ?? 'Nombre desconocido',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Licencia de Conducir: ${conductor.licenciaConducir ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Hora de Inicio: ${formatDateTime(conductor.horaInicio)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Hora de Término: ${formatDateTime(conductor.horaTermino)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Turno de Conducción: ${conductor.turnoConduccion ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (conductor.incidencia != null)
              Text(
                'Incidencia: ${conductor.incidencia!.descripcion ?? 'Sin descripción'}',
                style: const TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
