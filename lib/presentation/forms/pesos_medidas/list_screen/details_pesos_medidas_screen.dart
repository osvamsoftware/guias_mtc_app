import 'dart:io';

import 'package:app_remision/core/constants/texts.dart';
import 'package:app_remision/core/helpers/pdf/pdf_to_image.dart';
import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/hoja_de_ruta_details_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/form/cubit/pesos_medidas_form_cubit.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/form/pesos_medidas_screen.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:app_remision/presentation/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class VerificacionPesosMedidasDetail extends StatefulWidget {
  static const path = '/verificacion-pesos-medidas';
  final VerificacionPesosMedidasModel verificacion;

  const VerificacionPesosMedidasDetail({super.key, required this.verificacion});

  @override
  State<VerificacionPesosMedidasDetail> createState() => _VerificacionPesosMedidasDetailState();
}

class _VerificacionPesosMedidasDetailState extends State<VerificacionPesosMedidasDetail> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PesosMedidasFormCubit(
          context.read<VerificacionPesosMedidasRepository>(), context.read<LocalFormsRepository>()),
      child: Builder(builder: (context) {
        return BlocListener<PesosMedidasFormCubit, PesosMedidasFormState>(
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
              title: const Text('Detalles de Verificación'),
              actions: [
                IconButton(
                    onPressed: () => context.push(PesosMedidasFormScreen.path, extra: widget.verificacion),
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () => CustomDialogs.customAcceptOrCancel(
                        context: context,
                        title: 'Eliminar Guía',
                        bodyMessage: 'Se eliminará definitivamente la guía',
                        onAccept: () {
                          context.pop();
                          context.read<PesosMedidasFormCubit>().deleteForm(widget.verificacion.id ?? '');
                        },
                        onCancel: () => context.pop()),
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text(widget.verificacion.nombreEmpresa ?? '',
                            style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
                        const SizedBox(height: 5),
                        Text(texts.constancia, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 5),
                        Text(texts.almacenesTerminales,
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 5),
                        CustomNamedDivider(label: texts.datosGenerador, fontSize: 14),
                        const SizedBox(height: 5),

                        CustomDetailRow(label: 'ID Documento', value: widget.verificacion.id ?? 'N/A'),
                        CustomDetailRow(label: 'Nombre Empresa', value: widget.verificacion.nombreEmpresa ?? 'N/A'),
                        CustomDetailRow(label: 'Fecha', value: _formatDate(widget.verificacion.fecha)),
                        // CustomDetailRow(label: 'Registro', value: verificacion.registro ?? 'N/A'),
                        CustomDetailRow(label: 'RUC', value: widget.verificacion.ruc ?? 'N/A'),
                        CustomDetailRow(label: 'Teléfono', value: widget.verificacion.telefono ?? 'N/A'),
                        CustomDetailRow(label: 'Dirección', value: widget.verificacion.direccion ?? 'N/A'),
                        CustomDetailRow(label: 'Distrito', value: widget.verificacion.distrito ?? 'N/A'),
                        CustomDetailRow(label: 'Provincia', value: widget.verificacion.provincia ?? 'N/A'),
                        CustomDetailRow(label: 'Departamento', value: widget.verificacion.departamento ?? 'N/A'),
                        const SizedBox(height: 5),
                        CustomNamedDivider(label: texts.tipoMercancia, fontSize: 14),
                        const SizedBox(height: 5),
                        CustomDetailRow(label: 'Tipo de Control', value: widget.verificacion.tipoControl ?? 'N/A'),
                        const SizedBox(height: 5),
                        CustomNamedDivider(label: texts.datosVehiculo, fontSize: 14),
                        // const SizedBox(height: 5),
                        // CustomDetailRow(label: 'Placas', value: widget.verificacion.placas ?? 'N/A'),
                        CustomDetailRow(label: 'Largo', value: widget.verificacion.largo?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'Ancho', value: widget.verificacion.ancho?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'Alto', value: widget.verificacion.alto?.toString() ?? 'N/A'),
                        CustomDetailRow(
                            label: 'Configuración Vehicular',
                            value: widget.verificacion.configuracionVehicular ?? 'N/A'),
                        CustomDetailRow(
                            label: 'Peso Bruto Máximo (1)',
                            value: widget.verificacion.pesoBrutoMaximo?.toString() ?? 'N/A'),
                        CustomDetailRow(
                            label: 'Peso Transportado',
                            value: widget.verificacion.pesoTransportado?.toString() ?? 'N/A'),
                        CustomDetailRow(
                            label: 'PB Máx sin Control (2)',
                            value: widget.verificacion.pbMaxNoControl?.toString() ?? 'N/A'),
                        CustomDetailRow(
                            label: 'PB Máx con Bonificación (3)',
                            value: widget.verificacion.pbMaxConBonificacion?.toString() ?? 'N/A'),
                        const SizedBox(height: 5),
                        Text(texts.seObtienePuntos, style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 5),
                        CustomNamedDivider(label: texts.controlDePeso, fontSize: 14),
                        Text(texts.paraAquellosVehiculos),
                        const SizedBox(height: 5),
                        CustomDetailRow(label: 'CJTO1', value: widget.verificacion.cjto1?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'CJTO2', value: widget.verificacion.cjto2?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'CJTO3', value: widget.verificacion.cjto3?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'CJTO4', value: widget.verificacion.cjto4?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'CJTO5', value: widget.verificacion.cjto5?.toString() ?? 'N/A'),
                        CustomDetailRow(label: 'CJTO6', value: widget.verificacion.cjto6?.toString() ?? 'N/A'),
                        const SizedBox(height: 5),
                        Text(texts.decretoSupremo2, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const SizedBox(height: 5),
                        Text(texts.articulo37, style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 5),
                        CustomDetailRow(label: 'Observaciones', value: widget.verificacion.observaciones ?? 'N/A'),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (isLoading) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  _createPDF(context);
                                },
                                child: const Text('Generar PDF')),
                            const Text('El documento se guardará en tu carpeta de descargas.')
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildDetailItem(String fieldName, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fieldName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: ThemeColors.secondaryBlue,
            ),
          ),
          Flexible(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

//! -------------
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd-MM-yyyy').format(date);
  }

  Future<void> _createPDF(BuildContext context) async {
    late Uint8List? signatureImageData;
    // late Uint8List? logoData;

    final image = await getImage(path: 'assets/constancia.pdf');
    final formImage = image!.bytes;

    // //!--- get logo data
    // if (widget.verificacion.logoUrl != null && widget.verificacion.logoUrl != '') {
    //   final response = await http.get(Uri.parse(widget.verificacion.logoUrl ?? ''));
    //   if (response.statusCode == 200) {
    //     logoData = response.bodyBytes;
    //   } else {
    //     logoData = null;
    //   }
    // } else {
    //   logoData = null;
    // }

    //!--- get signature data
    final response = await http.get(Uri.parse(widget.verificacion.signatureUrl ?? ''));
    if (response.statusCode == 200) {
      signatureImageData = response.bodyBytes;
    } else {
      signatureImageData = null;
    }

    final pdf = pw.Document();

    List<pw.Widget> content = [
      pw.Center(child: pw.Image(pw.MemoryImage(formImage))),
      _setPositionedElement(
          x: 150,
          y: 0,
          child: pw.Container(
              constraints: const pw.BoxConstraints(maxWidth: 250),
              child: pw.Text(widget.verificacion.nombreEmpresa ?? '-------',
                  style: const pw.TextStyle(fontSize: 16), maxLines: 3, textAlign: pw.TextAlign.center))),
      // _setPositionedText(x: 100, y: 100, text: '100x100'),
      // _setPositionedText(x: 200, y: 200, text: '200x200'),
      // _setPositionedText(x: 300, y: 300, text: '300x300'),
      // _setPositionedText(x: 400, y: 400, text: '400x400'),
      _setPositionedText(x: 85, y: 120, text: _formatDate(widget.verificacion.fecha)),
      _setPositionedElement(x: 145, y: 125, child: pw.Container(height: 10, width: 30, color: PdfColors.white)),

      _setPositionedText(x: 390, y: 130, text: widget.verificacion.registro),
      _setPositionedText(x: 75, y: 156, text: widget.verificacion.nombreEmpresa),
      _setPositionedText(x: 300, y: 156, text: widget.verificacion.ruc),
      _setPositionedText(x: 400, y: 156, text: widget.verificacion.telefono),
      _setPositionedText(x: 75, y: 168, text: widget.verificacion.direccion),
      _setPositionedText(x: 75, y: 180, text: widget.verificacion.distrito),
      _setPositionedText(x: 230, y: 180, text: widget.verificacion.provincia),
      _setPositionedText(x: 380, y: 180, text: widget.verificacion.departamento),
      _setPositionedElement(
          x: 160,
          y: 200,
          child: pw.Container(
              width: 300,
              child: pw.Wrap(
                  children: List.generate(
                widget.verificacion.guias?.length ?? 0,
                (index) =>
                    pw.Text("GUÍA $index: ${widget.verificacion.guias?[index]}     ", style: pw.TextStyle(fontSize: 6)),
              )))),
      // ...List.generate(
      //   widget.verificacion.guias?.length ?? 0,
      //   (index) => _setPositionedText(x: 160, y: 190 + (index * 6), text: "GUIA: ${widget.verificacion.guias?[index]}"),
      // ),

      //! ----------------------------------------------------------------
      if (widget.verificacion.tipoControl == 'balanza') _setPositionedText(x: 90, y: 225, text: 'X'),
      if (widget.verificacion.tipoControl == 'software') _setPositionedText(x: 200, y: 225, text: 'X'),
      if (widget.verificacion.tipoControl == 'cubicacion') _setPositionedText(x: 300, y: 225, text: 'X'),
      if (widget.verificacion.tipoControl == 'otros') _setPositionedText(x: 420, y: 225, text: 'X'),

      //! ----------------------------------------------------------------
      _setPositionedText(x: 30, y: 290, text: widget.verificacion.placas1),
      _setPositionedText(x: 30, y: 300, text: widget.verificacion.placas2),
      _setPositionedText(x: 30, y: 310, text: widget.verificacion.placas3),

      _setPositionedText(
          x: 100, y: 300, text: (widget.verificacion.largo != 0) ? widget.verificacion.largo.toString() : ''),
      _setPositionedText(
          x: 130, y: 300, text: (widget.verificacion.ancho != 0) ? widget.verificacion.ancho.toString() : ''),
      _setPositionedText(
          x: 150, y: 300, text: (widget.verificacion.alto != 0) ? widget.verificacion.alto.toString() : ''),
      _setPositionedText(x: 180, y: 300, text: widget.verificacion.configuracionVehicular),
      _setPositionedText(
          x: 230,
          y: 300,
          text: (widget.verificacion.pesoBrutoMaximo != 0) ? widget.verificacion.pesoBrutoMaximo.toString() : ''),
      _setPositionedText(
          x: 280,
          y: 300,
          text: (widget.verificacion.pesoTransportado != 0) ? widget.verificacion.pesoTransportado.toString() : ''),
      _setPositionedText(
          x: 340,
          y: 300,
          text: (widget.verificacion.pbMaxNoControl != 0) ? widget.verificacion.pbMaxNoControl.toString() : ''),
      _setPositionedText(
          x: 400,
          y: 300,
          text: (widget.verificacion.pbMaxConBonificacion != 0)
              ? widget.verificacion.pbMaxConBonificacion.toString()
              : ''),

      //! ----------------------------------------------------------------
      _setPositionedText(
          x: 100, y: 430, text: (widget.verificacion.cjto1 != 0) ? widget.verificacion.cjto1.toString() : ''),
      _setPositionedText(
          x: 160, y: 430, text: (widget.verificacion.cjto2 != 0) ? widget.verificacion.cjto2.toString() : ''),
      _setPositionedText(
          x: 220, y: 430, text: (widget.verificacion.cjto3 != 0) ? widget.verificacion.cjto3.toString() : ''),
      _setPositionedText(
          x: 300, y: 430, text: (widget.verificacion.cjto4 != 0) ? widget.verificacion.cjto4.toString() : ''),
      _setPositionedText(
          x: 360, y: 430, text: (widget.verificacion.cjto5 != 0) ? widget.verificacion.cjto5.toString() : ''),
      _setPositionedText(
          x: 420, y: 430, text: (widget.verificacion.cjto6 != 0) ? widget.verificacion.cjto6.toString() : ''),

      _setPositionedElement(
          x: 25,
          y: 480,
          child: pw.Container(
              color: PdfColors.white,
              height: 6,
              width: 200,
              child: pw.Text('permitido por el presente reglamento o sus normas complementarias.',
                  style: const pw.TextStyle(fontSize: 5)))),

      //! ----------------------------------------------------------------
      _setPositionedText(x: 100, y: 500, text: widget.verificacion.observaciones),

      //! ----------------------------------------------------------------

      _setPositionedElement(
          x: 80, y: 525, child: pw.Center(child: pw.Image(pw.MemoryImage(signatureImageData!), height: 25))),

      _setPositionedElement(
          x: 20,
          y: 543,
          child: pw.Container(
              width: 160,
              // color: PdfColors.red,
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                if (widget.verificacion.personaJuridica == true)
                  pw.Text(widget.verificacion.nombreEmpresa?.toUpperCase() ?? '--',
                      style: pw.TextStyle(fontSize: 6, color: PdfColors.indigo, fontWeight: pw.FontWeight.bold)),
                pw.Text(widget.verificacion.nombreRepresentante?.toUpperCase() ?? '--------',
                    style: pw.TextStyle(fontSize: 6, color: PdfColors.indigo, fontWeight: pw.FontWeight.bold)),
                if (widget.verificacion.personaJuridica == true)
                  pw.Text('GERENTE',
                      style: pw.TextStyle(fontSize: 6, color: PdfColors.indigo, fontWeight: pw.FontWeight.bold)),
                if (widget.verificacion.personaJuridica == false)
                  pw.Text("DNI: ${widget.verificacion.dni}",
                      style: pw.TextStyle(fontSize: 6, color: PdfColors.indigo, fontWeight: pw.FontWeight.bold))
              ]))),
    ];

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(children: content);
        },
      ),
    );
    setState(() {
      isLoading = false;
    });

    final directory = Directory('/storage/emulated/0/Download/VPM/${_formatDate(widget.verificacion.fecha)}');
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
    final filePath =
        '${directory.path}/VPM_${widget.verificacion.ruc}_${_formatDate(widget.verificacion.fecha)}_1_${widget.verificacion.version}_${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 11)}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  pw.Widget _setPositionedText({double? x, double? y, String? text}) {
    return pw.Positioned(top: y, left: x, child: pw.Text(text ?? '///-///', style: const pw.TextStyle(fontSize: 7)));
  }

  pw.Widget _setPositionedElement({double? x, double? y, required pw.Widget child}) {
    return pw.Positioned(
      top: y,
      left: x,
      child: child,
    );
  }
}

///storage/emulated/0/Download/VPM/30-10-2024/VPM_20609413418_30-10-2024_1_2.pdf
///storage/emulated/0/Download/VPM/30-10-2024/VPM_20609413418_30-10-2024_1_1.pdf