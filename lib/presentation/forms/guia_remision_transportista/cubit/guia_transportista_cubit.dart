// import 'package:app_remision/data/models/api_guia_remitente_model.dart';
import 'dart:convert';

import 'package:app_remision/core/settings/exception_handler.dart';
import 'package:app_remision/data/models/api_guia_transportista_model.dart';
import 'package:app_remision/data/models/ticket_response_model.dart';
import 'package:app_remision/domain/repository/guia_transportista_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'guia_transportista_state.dart';

class GuiaTransportistaCubit extends Cubit<GuiaTransportistaState> {
  final GuiaTransportistaRepository _guiaTransportistaRepository;
  GuiaTransportistaCubit(this._guiaTransportistaRepository)
      : super(const GuiaTransportistaState(
            unidadPesoItem: '1',
            tipoDocumentoConductorTemp: '1',
            tipoDocumento: '1',
            guiaTransportistaStatus: GuiaTransportistaStatus.initial,
            guiaTransportistaModel: ApiGuiaTransportistaModel(
                contratoVehicular: '1',
                remitente: Usuario(codigoTipoDocumentoIdentidad: '1'),
                destinatario: Usuario(codigoTipoDocumentoIdentidad: '1'))));

  //controllers para el modelo ApiGuiaTransportistaModel
  // Controllers para ApiGuiaTransportistaModel
  final TextEditingController serieDocumentoController = TextEditingController();
  final TextEditingController numeroDocumentoController = TextEditingController();
  final TextEditingController fechaDeEmisionController = TextEditingController();
  final TextEditingController fechaDeTransladoController = TextEditingController();

  final TextEditingController codigoTipoDocumentoController = TextEditingController();
  final TextEditingController observacionesController = TextEditingController();
  final TextEditingController pesoTotalController = TextEditingController();

  // Controllers para Usuario (remitente y destinatario)
  final TextEditingController codigoTipoDocumentoIdentidadRemitenteController = TextEditingController();
  final TextEditingController numeroDocumentoRemitenteController = TextEditingController();
  final TextEditingController apellidosYNombresORazonSocialRemitenteController = TextEditingController();

  final TextEditingController codigoTipoDocumentoIdentidadDestinatarioController = TextEditingController();
  final TextEditingController numeroDocumentoDestinatarioController = TextEditingController();
  final TextEditingController apellidosYNombresORazonSocialDestinatarioController = TextEditingController();

  // Controllers para Direccion (direccionPartidaRemitente y direccionLlegadaDestinatario)
  final TextEditingController ubigeoDireccionController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();

  // Controllers para Chofer
  final TextEditingController registroMTCController = TextEditingController();
  final TextEditingController codigoTipoDocumentoIdentidadChoferController = TextEditingController(text: '1');
  final TextEditingController numeroDocumentoChoferController = TextEditingController();
  final TextEditingController nombresChoferController = TextEditingController();
  final TextEditingController apellidosChoferController = TextEditingController();
  final TextEditingController numeroLicenciaChoferController = TextEditingController();
  final TextEditingController telefonoChoferController = TextEditingController();

  //Controllers para vehículo
  final TextEditingController numeroDePlacaController = TextEditingController();
  final TextEditingController tucChbController = TextEditingController();
  final TextEditingController autorizacionController = TextEditingController();
  final TextEditingController entidadEmisoraController = TextEditingController();

  // Controllers para DatosDelEmisor
  final TextEditingController codigoPaisEmisorController = TextEditingController();
  final TextEditingController ubigeoEmisorController = TextEditingController();
  final TextEditingController direccionEmisorController = TextEditingController();
  final TextEditingController correoElectronicoEmisorController = TextEditingController();
  final TextEditingController telefonoEmisorController = TextEditingController();
  final TextEditingController codigoDelDomicilioFiscalEmisorController = TextEditingController();

  // Controllers para Item
  final TextEditingController codigoInternoItemController = TextEditingController();
  final TextEditingController unidadesItemController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController partidaArancelariaController = TextEditingController();

  //Controller para documentos
  final TextEditingController documentoSerieController = TextEditingController();
  final TextEditingController documentoRucController = TextEditingController();
  final TextEditingController ddocumentoDescriptionController = TextEditingController();

  //! --- LOCAL METHODS

  void onRemitentDocumentTypeChange(String type) {
    emit(state.copyWith(
        guiaTransportistaModel: state.guiaTransportistaModel.copyWith(
            remitente: state.guiaTransportistaModel.remitente?.copyWith(codigoTipoDocumentoIdentidad: type))));
  }

  void onDestinatarioDocumentTypeChange(String type) {
    emit(state.copyWith(
        guiaTransportistaModel: state.guiaTransportistaModel.copyWith(
            destinatario: state.guiaTransportistaModel.destinatario?.copyWith(codigoTipoDocumentoIdentidad: type))));
  }

  void onFechaDeEmisionChange(DateTime date) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(fechaDeEmision: date)));
    fechaDeEmisionController.text = '${date.year}-${date.month}-${date.day}';
  }

  void onFechaDeTrasladoChange(DateTime date) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(fechaDeTraslado: date)));
    fechaDeTransladoController.text = '${date.year}-${date.month}-${date.day}';
  }

  void onRetornoDeVehiculoVacio(bool value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(vehiculoVacio: value)));
  }

  void onEnvasesVaciosChange(bool value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(envasesVacios: value)));
  }

  void onTransbordoProgramadoChange(bool value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(transbordoProgramado: value)));
  }

  void onTrasladoTotalDeBienesChange(bool value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(transladoTotalDeBienes: value)));
  }

  void onTransporteSubcontratadoChange(bool value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(transporteSubcontratado: value)));
  }

  void onFleteChange(String value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(contratoVehicular: value)));
  }

  // ---- Conductor
  void onConductorDocumentTypeChange(String type) {
    emit(state.copyWith(tipoDocumentoConductorTemp: type));
  }

  void onAddConductor() {
    final chofer = Chofer(
        codigoTipoDocumentoIdentidad: state.tipoDocumentoConductorTemp,
        numeroDocumento: numeroDocumentoChoferController.text,
        nombres: "${nombresChoferController.text} ${apellidosChoferController.text}",
        numeroLicencia: numeroLicenciaChoferController.text,
        telefono: telefonoChoferController.text);
    emit(state.copyWith(
        guiaTransportistaModel:
            state.guiaTransportistaModel.copyWith(chofer: [...(state.guiaTransportistaModel.chofer ?? []), chofer])));
    nombresChoferController.clear();
    apellidosChoferController.clear();
    numeroLicenciaChoferController.clear();
    telefonoChoferController.clear();
  }

  void deleteConductor(int index) {
    final newChoferList = List<Chofer>.from(state.guiaTransportistaModel.chofer!);
    newChoferList.removeAt(index);
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(chofer: newChoferList)));
  }

// ------ Vehiculos
  void onAddVehiculo() {
    final vehiculo = Vehiculo(
        numeroDePlaca: numeroDePlacaController.text, modelo: tucChbController.text, marca: autorizacionController.text);
    emit(state.copyWith(
        guiaTransportistaModel: state.guiaTransportistaModel
            .copyWith(vehiculo: [...(state.guiaTransportistaModel.vehiculo ?? []), vehiculo])));
    numeroDePlacaController.clear();
    tucChbController.clear();
    autorizacionController.clear();
  }

  void onDeleteVehiculo(int index) {
    final newVehiculoList = List<Vehiculo>.from(state.guiaTransportistaModel.vehiculo!);
    newVehiculoList.removeAt(index);
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(vehiculo: newVehiculoList)));
  }

// ------- Items
  void onUnityChange(String value) {
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(unidadPesoTotal: value)));
  }

  void onItemUnityChange(String value) {
    emit(state.copyWith(unidadPesoItem: value));
  }

  void onAddItem() {
    final item =
        Item(codigoInterno: codigoInternoItemController.text, cantidad: int.tryParse(unidadesItemController.text));
    emit(state.copyWith(
        guiaTransportistaModel:
            state.guiaTransportistaModel.copyWith(items: [...(state.guiaTransportistaModel.items ?? []), item])));
    codigoInternoItemController.clear();
    unidadesItemController.clear();
  }

  void onDeleteItem(int value) {
    final newItem = List<Item>.from(state.guiaTransportistaModel.items!);
    newItem.removeAt(value);
    emit(state.copyWith(guiaTransportistaModel: state.guiaTransportistaModel.copyWith(items: newItem)));
  }

// ----- Documentos Relacionados

  void onTipoDocumentoChange(String value) {
    emit(state.copyWith(tipoDocumento: value));
  }

  void onAddDocument() {
    final documentoAfectado = DocumentoAfectado(
        serieDocumento: documentoSerieController.text,
        numeroDocumento: documentoRucController.text,
        codigoTipoDocumento: state.tipoDocumento);
    emit(state.copyWith(
        guiaTransportistaModel: state.guiaTransportistaModel.copyWith(
            documentoAfectado: [...(state.guiaTransportistaModel.documentoAfectado ?? []), documentoAfectado])));
    documentoSerieController.clear();
    documentoRucController.clear();
  }

// ------  Emitir la Guia al Api

  Future<void> onSubmmitEmitirGuiaTransportista() async {
    try {
      emit(state.copyWith(guiaTransportistaStatus: GuiaTransportistaStatus.loading));
      // TODO registrar los items de mercancia y obtener la clave de cada uno, mientras se va armando el modelo de cada producto para enviar

      // TODO armamos el modelo de la Guía de transportista final

      final guiaModel = state.guiaTransportistaModel.copyWith(
        serieDocumento: serieDocumentoController.text,
        numeroDocumento: numeroDocumentoController.text,
        fechaDeEmision: DateTime.parse(fechaDeEmisionController.text),
        horaDeEmision: '10:00:00',
        codigoTipoDocumento: '31',
        //todo, los datos del usuario de la app
        datosDelEmisor: DatosDelEmisor(
          codigoPais: 'PE',
          ubigeo: '150101',
          direccion: 'Av. Larco 123',
          correoElectronico: 'example@example.com',
          telefono: '999999999',
          codigoDelDomicilioFiscal: '0000',
        ),
        observaciones: observacionesController.text,
        fechaDeTraslado: DateTime.parse(fechaDeTransladoController.text),
        unidadPesoTotal: 'KG',
        pesoTotal: int.tryParse(pesoTotalController.text),
        remitente: state.guiaTransportistaModel.remitente?.copyWith(
            numeroDocumento: numeroDocumentoRemitenteController.text,
            apellidosYNombresORazonSocial: apellidosYNombresORazonSocialRemitenteController.text),
        direccionPartidaRemitente: Direccion(ubigeo: '150101', direccion: 'Av. Larco 123'),
        destinatario: state.guiaTransportistaModel.destinatario?.copyWith(
            numeroDocumento: numeroDocumentoDestinatarioController.text,
            apellidosYNombresORazonSocial: apellidosYNombresORazonSocialDestinatarioController.text),
        direccionLlegadaDestinatario: Direccion(ubigeo: '150101', direccion: 'Av. Larco 123'),
        chofer: state.guiaTransportistaModel.chofer,
        vehiculo: state.guiaTransportistaModel.vehiculo,
        items: state.guiaTransportistaModel.items,
      );
      final jsonForm = guiaModel.toJson();
      print(jsonForm);
      // Todo enviamos al API la guía de transportista, y esperamos la respuesta

      // try {
      //   // gina
      //   final guiaTransportistaResponse = await _guiaTransportistaRepository.createGuiaTransportista(guiaTransportista);
      // } on ApiException catch (e) {}

      // Todo enviamos la Response al API de sunat

      // Todo consultamos la respuesta y obtenemos los documentos

      // Todo registramos en nuestra base de Datos en Firebase
    } on ApiException catch (e) {
    } catch (e) {}
  }

  void onRemitentRucSearch() {}
  void onDestinatarioRucSearch() {}
}
