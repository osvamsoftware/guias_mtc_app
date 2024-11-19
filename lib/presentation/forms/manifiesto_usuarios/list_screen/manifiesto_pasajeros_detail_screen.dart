import 'dart:io';
import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/hoja_de_ruta_details_screen.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/form_screen/cubit/manifiesto_usuarios_cubit.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/form_screen/manifest_form_screen.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class ManifiestoDetailsScreen extends StatelessWidget {
  static const path = '/manifiesto-details-screen';
  final ManifiestoModel manifiesto;

  const ManifiestoDetailsScreen({super.key, required this.manifiesto});

  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime? date) {
      if (date == null) return 'N/A';
      return DateFormat('dd-MM-yyyy').format(date);
    }

    return BlocProvider(
      create: (context) => ManifiestoCubit(
        context.read<ManifiestoRepository>(),
        context.read<LocalFormsRepository>(),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Detalles del Manifiesto'),
            actions: [
              IconButton(
                  onPressed: () => context.push(ManifiestoFormScreen.path, extra: manifiesto),
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () => context.read<ManifiestoCubit>().deleteForm(manifiesto.id ?? ''),
                  icon: const Icon(Icons.delete))
            ],
          ),
          body: BlocListener<ManifiestoCubit, ManifiestoFormState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status == FormzSubmissionStatus.inProgress) {
                CustomDialogs.loadingDialog(context);
              }
              if (state.status == FormzSubmissionStatus.success) {
                CustomDialogs.successDialog(
                    context: context,
                    onPressed: () => context.pushReplacement(HomeScreen.path),
                    successMessage: state.message);
              }
              if (state.status == FormzSubmissionStatus.failure) {
                CustomDialogs.errorDialog(context, state.message);
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      CustomDetailRow(
                        label: 'Razón Social',
                        value: manifiesto.razonSocial ?? 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Dirección',
                        value: manifiesto.direccion ?? 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Teléfono',
                        value: manifiesto.telefono ?? 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Correo Electrónico',
                        value: manifiesto.correoElectronico ?? 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Fecha de Viaje',
                        value: manifiesto.fechaViaje != null ? _formatDate(manifiesto.fechaViaje) : 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Placa Vehicular',
                        value: manifiesto.placaVehicular ?? 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Ruta',
                        value: manifiesto.ruta ?? 'N/A',
                      ),
                      CustomDetailRow(
                        label: 'Modalidad de Servicio',
                        value: manifiesto.modalidadServicio ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Pasajeros:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      manifiesto.pasajeros != null && manifiesto.pasajeros!.isNotEmpty
                          ? Column(
                              children: manifiesto.pasajeros!.map((pasajero) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomDetailRow(
                                      label: 'Apellidos y Nombres',
                                      value: pasajero.apellidosNombres ?? 'N/A',
                                    ),
                                    CustomDetailRow(
                                      label: 'Documento de Identidad',
                                      value: pasajero.documentoIdentidad ?? 'N/A',
                                    ),
                                    CustomDetailRow(
                                      label: 'Edad',
                                      value: pasajero.edad?.toString() ?? 'N/A',
                                    ),
                                    const Divider(),
                                  ],
                                );
                              }).toList(),
                            )
                          : const Text('No hay pasajeros.'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _generateAndOpenPdf(context),
                  child: const Text('Generar PDF'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _generateAndOpenPdf(BuildContext context) async {
    String formatDate(DateTime? date) {
      if (date == null) return 'N/A';
      return DateFormat('dd/MM/yyyy').format(date);
    }

    int index = 0;

    final pasajerosfinal = manifiesto.pasajeros!.map(
      (e) {
        index++;
        return e.copyWith(id: index.toString());
      },
    ).toList();

    final pdf = pw.Document();

    List<List<Pasajero>> passengerChunks = [];
    int chunkSize = 30;
    for (var i = 0; i < pasajerosfinal.length; i += chunkSize) {
      passengerChunks.add(pasajerosfinal.sublist(
        i,
        i + chunkSize > pasajerosfinal.length ? pasajerosfinal.length : i + chunkSize,
      ));
    }

    for (var chunk in passengerChunks) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text('MANIFIESTO DE USUARIOS',
                      style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                ),
                pw.SizedBox(height: 10),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceAround, children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('RAZON SOCIAL: ${manifiesto.razonSocial}', style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('Dirección: ${manifiesto.direccion}', style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('Número de Teléfono: ${manifiesto.telefono}', style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('Correo Electrónico: ${manifiesto.correoElectronico}',
                            style: const pw.TextStyle(fontSize: 10)),
                      ]),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Fecha de viaje: ${formatDate(manifiesto.fechaViaje)}',
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('N° de Placa Vehicular: ${manifiesto.placaVehicular}',
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('Ruta: ${manifiesto.ruta}', style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('Modalidad del servicio: ${manifiesto.modalidadServicio}',
                            style: const pw.TextStyle(fontSize: 10)),
                      ])
                ]),
                pw.SizedBox(height: 10),
                _buildTable(chunk),
              ],
            );
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/verificacion_${manifiesto.id}.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  pw.Widget _buildTable(List<Pasajero> usuarios) {
    return pw.TableHelper.fromTextArray(
      cellStyle: const pw.TextStyle(fontSize: 9),
      headers: ['N°', 'APELLIDOS Y NOMBRES', 'N° DOCUMENTO DE IDENTIDAD', 'EDAD'],
      data: List.generate(
        usuarios.length,
        (index) => [
          usuarios[index].id,
          usuarios[index].apellidosNombres,
          usuarios[index].documentoIdentidad,
          usuarios[index].edad.toString(),
        ],
      ),
    );
  }
}
