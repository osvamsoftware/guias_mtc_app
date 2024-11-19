import 'dart:io';

import 'package:app_remision/core/constants/texts.dart';
import 'package:app_remision/core/helpers/pdf/pdf_to_image.dart';
import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/form_screen/cubit/hoja_de_ruta_cubit.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/form_screen/hoja_de_ruta_form_screen.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:app_remision/presentation/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class HojaDeRutaDetailScreen extends StatelessWidget {
  static const path = '/hoja-de-ruta-detail';
  final HojaDeRutaModel hojaDeRuta;

  const HojaDeRutaDetailScreen({super.key, required this.hojaDeRuta});

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String _formatDateAndHour(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HojaDeRutaCubit(context.read<HojaDeRutaRepository>(), context.read<LocalFormsRepository>()),
      child: Builder(builder: (context) {
        return BlocListener<HojaDeRutaCubit, HojaDeRutaFormState>(
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
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Detalle de Hoja de Ruta'),
              actions: [
                IconButton(
                    onPressed: () => context.push(HojaDeRutaFormScreen.path, extra: hojaDeRuta),
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () => CustomDialogs.customAcceptOrCancel(
                        context: context,
                        title: 'Eliminar Hoja de Ruta',
                        bodyMessage: 'Se eliminará definitivamente la Hoja de Ruta',
                        onAccept: () {
                          context.pop();
                          context.read<HojaDeRutaCubit>().deleteForm(hojaDeRuta.id ?? '');
                        },
                        onCancel: () => context.pop()),
                    icon: const Icon(Icons.delete)),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        CustomDetailRow(label: 'Razón Social', value: hojaDeRuta.razonSocial ?? 'N/A'),
                        CustomDetailRow(label: 'RUC', value: hojaDeRuta.ruc ?? 'N/A'),
                        CustomDetailRow(label: 'Modalidad de Servicio', value: hojaDeRuta.modalidadServicio ?? 'N/A'),
                        CustomDetailRow(label: 'Número de Pasajeros', value: hojaDeRuta.numPasajeros.toString()),
                        CustomNamedDivider(label: texts.datosViaje, fontSize: 13),
                        CustomDetailRow(label: 'Departamento Origen', value: hojaDeRuta.departamentoOrigen ?? 'N/A'),
                        CustomDetailRow(label: 'Provincia Origen', value: hojaDeRuta.provinciaOrigen ?? 'N/A'),
                        CustomDetailRow(label: 'Distrito Origen', value: hojaDeRuta.distritoOrigen ?? 'N/A'),
                        CustomDetailRow(label: 'Dirección Origen', value: hojaDeRuta.direccionOrigen ?? 'N/A'),
                        CustomDetailRow(label: 'Hora de Salida', value: _formatDate(hojaDeRuta.horaSalida)),
                        CustomDetailRow(
                            label: 'Fecha Inicio de Viaje', value: _formatDate(hojaDeRuta.fechaInicioViaje)),
                        CustomDetailRow(label: 'Terminal de Salida', value: hojaDeRuta.terminalSalida ?? 'N/A'),
                        CustomDetailRow(label: 'Departamento Destino', value: hojaDeRuta.departamentoDestino ?? 'N/A'),
                        CustomDetailRow(label: 'Provincia Destino', value: hojaDeRuta.provinciaDestino ?? 'N/A'),
                        CustomDetailRow(label: 'Distrito Destino', value: hojaDeRuta.distritoDestino ?? 'N/A'),
                        CustomDetailRow(label: 'Dirección Destino', value: hojaDeRuta.direccionDestino ?? 'N/A'),
                        CustomDetailRow(
                            label: 'Fecha Llegada de Viaje', value: _formatDate(hojaDeRuta.fechaLlegadaViaje)),
                        CustomDetailRow(label: 'Hora de Llegada', value: _formatDate(hojaDeRuta.horaLlegada)),
                        CustomDetailRow(label: 'Terminal de Llegada', value: hojaDeRuta.terminalLlegada ?? 'N/A'),
                        CustomNamedDivider(label: texts.datosItinerario, fontSize: 13),
                        ...hojaDeRuta.itinerarioList.map((itinerario) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDetailRow(label: 'Departamento', value: itinerario.departamento ?? 'N/A'),
                              CustomDetailRow(label: 'Provincia', value: itinerario.provincia ?? 'N/A'),
                              CustomDetailRow(label: 'Distrito', value: itinerario.distrito ?? 'N/A'),
                              const Divider()
                            ],
                          );
                        }),
                        const SizedBox(height: 16.0),
                        const CustomNamedDivider(label: 'Conductores', fontSize: 13),
                        const SizedBox(height: 8.0),
                        ...hojaDeRuta.conductores?.map((conductor) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomDetailRow(label: 'Nombre', value: conductor.nombre ?? 'N/A'),
                                  CustomDetailRow(
                                      label: 'Licencia de Conducir', value: conductor.licenciaConducir ?? 'N/A'),
                                  CustomDetailRow(label: 'Hora de Inicio', value: _formatDate(conductor.horaInicio)),
                                  CustomDetailRow(label: 'Hora de Término', value: _formatDate(conductor.horaTermino)),
                                  CustomDetailRow(
                                      label: 'Turno de Conducción', value: conductor.turnoConduccion ?? 'N/A'),
                                  if (conductor.incidencia != null) ...[
                                    const SizedBox(height: 8.0),
                                    const Text('Incidencia:', style: TextStyle(fontWeight: FontWeight.bold)),
                                    CustomDetailRow(
                                        label: 'Descripción', value: conductor.incidencia!.descripcion ?? 'N/A'),
                                    CustomDetailRow(label: 'Lugar', value: conductor.incidencia!.lugar ?? 'N/A'),
                                    CustomDetailRow(
                                        label: 'Fecha y Hora', value: _formatDate(conductor.incidencia!.fechaHora)),
                                  ],
                                  const Divider(),
                                ],
                              );
                            }).toList() ??
                            [],
                        CustomNamedDivider(label: texts.datosVehiculo, fontSize: 13),
                        CustomDetailRow(label: 'Estado', value: hojaDeRuta.estado ?? 'N/A'),
                        CustomDetailRow(label: 'Revisión Técnica', value: hojaDeRuta.revisionTecnica ?? 'N/A'),
                        CustomDetailRow(label: 'SOAT', value: hojaDeRuta.soat ?? 'N/A'),
                        CustomDetailRow(label: 'Ruta', value: hojaDeRuta.ruta ?? 'N/A'),
                        CustomDetailRow(label: 'Correo Electrónico', value: hojaDeRuta.correoElectronico ?? 'N/A'),
                        CustomDetailRow(label: 'Número de Placa', value: hojaDeRuta.numeroPlaca ?? 'N/A'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _createPDF(context),
                    child: const Text('Generar PDF'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _createPDF(BuildContext context) async {
    final image = await getImage(path: 'assets/hoja_ruta.pdf', pageIndex: 1);
    final formImage = image!.bytes;

    final pdf = pw.Document();

    List<pw.Widget> content = [
      pw.Center(child: pw.Image(pw.MemoryImage(formImage))),
      _setPositionedText(x: 240, y: 70, text: hojaDeRuta.folio),
      _setPositionedText(x: 90, y: 95, text: hojaDeRuta.razonSocial),
      _setPositionedText(x: 90, y: 110, text: hojaDeRuta.direccion),
      _setPositionedText(x: 90, y: 125, text: hojaDeRuta.correoElectronico),
      _setPositionedText(x: 400, y: 125, text: '5566778899'),
      //placas
      ...List.generate(hojaDeRuta.numeroPlaca?.length ?? 0,
          (index) => _setPositionedText(x: 85 + (index * 10), y: 140, text: hojaDeRuta.numeroPlaca?[index])),

      _setPositionedText(x: 250, y: 140, text: _formatDate(hojaDeRuta.fechaInicioViaje)),
      _setPositionedText(x: 380, y: 140, text: _formatDate(hojaDeRuta.fechaLlegadaViaje)),

      //!-------------------------------

      _setPositionedElement(
          x: 110,
          y: 180,
          child: pw.Row(children: [
            pw.Text(hojaDeRuta.departamentoOrigen ?? '', style: const pw.TextStyle(fontSize: 7)),
            pw.SizedBox(width: 5),
            pw.Text(hojaDeRuta.provinciaOrigen ?? '', style: const pw.TextStyle(fontSize: 7)),
            pw.SizedBox(width: 5),
            pw.Text(hojaDeRuta.distritoOrigen ?? '', style: const pw.TextStyle(fontSize: 7))
          ])),
      _setPositionedElement(
          x: 110,
          y: 195,
          child: pw.Row(children: [
            pw.Text(hojaDeRuta.departamentoDestino ?? '', style: const pw.TextStyle(fontSize: 7)),
            pw.SizedBox(width: 5),
            pw.Text(hojaDeRuta.provinciaDestino ?? '', style: const pw.TextStyle(fontSize: 7)),
            pw.SizedBox(width: 5),
            pw.Text(hojaDeRuta.distritoDestino ?? '', style: const pw.TextStyle(fontSize: 7))
          ])),
      // _setPositionedText(x: 110, y: 180, text: hojaDeRuta.terminalSalida),
      // _setPositionedText(x: 110, y: 195, text: hojaDeRuta.terminalLlegada),

      _setPositionedText(x: 110, y: 210, text: hojaDeRuta.escalasComerciales),
      _setPositionedText(x: 110, y: 240, text: "${_formatDateAndHour(hojaDeRuta.horaSalida)} hrs"),
      _setPositionedText(x: 110, y: 255, text: "${_formatDateAndHour(hojaDeRuta.horaLlegada)} hrs"),

      //! -------------------------------
      //first conductor
      _setPositionedText(text: hojaDeRuta.conductores?[0].nombre, x: 80, y: 290),
      _setPositionedText(text: hojaDeRuta.conductores?[0].licenciaConducir, x: 390, y: 290),
      //second conductor
      if (hojaDeRuta.conductores!.length > 1)
        _setPositionedText(text: hojaDeRuta.conductores?[1].nombre, x: 80, y: 320),
      if (hojaDeRuta.conductores!.length > 1)
        _setPositionedText(text: hojaDeRuta.conductores?[1].licenciaConducir, x: 390, y: 320),
      //thirth conductor
      if (hojaDeRuta.conductores!.length > 2)
        _setPositionedText(text: hojaDeRuta.conductores?[2].nombre, x: 80, y: 355),
      if (hojaDeRuta.conductores!.length > 2)
        _setPositionedText(text: hojaDeRuta.conductores?[2].licenciaConducir, x: 390, y: 355),
      if (hojaDeRuta.conductores?[0].incidencia?.descripcion != null &&
          hojaDeRuta.conductores?[0].incidencia?.descripcion != '') //!--- First incidencia
        ...[
        _setPositionedText(x: 80, y: 400, text: hojaDeRuta.conductores?[0].nombre ?? ''),
        _setPositionedText(x: 230, y: 400, text: hojaDeRuta.conductores?[0].incidencia?.lugar ?? ''),
        _setPositionedText(x: 350, y: 400, text: _formatDate(hojaDeRuta.conductores?[0].incidencia?.fechaHora)),
        _setPositionedElement(
            x: 110,
            y: 425,
            child: pw.Container(
                width: 200,
                child: pw.Text(hojaDeRuta.conductores?[0].incidencia?.descripcion ?? '',
                    style: const pw.TextStyle(fontSize: 6)))),
        _setPositionedText(x: 400, y: 445, text: hojaDeRuta.conductores?[0].licenciaConducir.toString()),
      ],
      //!--- Second incidencia
      if (hojaDeRuta.conductores!.length > 1 &&
          hojaDeRuta.conductores?[1].incidencia?.descripcion != null &&
          hojaDeRuta.conductores?[1].incidencia?.descripcion != '') ...[
        _setPositionedText(x: 80, y: 475, text: hojaDeRuta.conductores?[1].nombre ?? ''),
        _setPositionedText(x: 230, y: 475, text: hojaDeRuta.conductores?[1].incidencia?.lugar ?? ''),
        _setPositionedText(x: 350, y: 475, text: _formatDate(hojaDeRuta.conductores?[1].incidencia?.fechaHora)),
        _setPositionedElement(
            x: 110,
            y: 500,
            child: pw.Container(
                width: 200,
                child: pw.Text(hojaDeRuta.conductores?[1].incidencia?.descripcion ?? '',
                    style: const pw.TextStyle(fontSize: 6)))),
        _setPositionedText(x: 400, y: 525, text: hojaDeRuta.conductores?[1].licenciaConducir.toString())
      ]
    ];

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(children: content);
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
        "${output.path}/hoja_ruta_${hojaDeRuta.ruc}_V1_${hojaDeRuta.version.toString()}_${_formatDate(hojaDeRuta.fechaInicioViaje)}.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  pw.Widget _setPositionedText({double? x, double? y, String? text}) {
    return pw.Positioned(top: y, left: x, child: pw.Text(text ?? '///-///', style: const pw.TextStyle(fontSize: 7)));
  }

  pw.Widget _setPositionedElement({double? x, double? y, required pw.Widget child}) {
    return pw.Positioned(top: y, left: x, child: child);
  }
}

class CustomDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const CustomDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ThemeColors.secondaryBlue),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
