import 'package:app_remision/core/helpers/signature/connectivity/wifi_settings.dart';
import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/form/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

part 'pesos_medidas_form_state.dart';

class PesosMedidasFormCubit extends Cubit<PesosMedidasFormState> {
  final VerificacionPesosMedidasRepository _repository;
  final LocalFormsRepository _localFormsRepository;
  final TextEditingController dateController = TextEditingController();
  PesosMedidasFormCubit(this._repository, this._localFormsRepository)
      : super(const PesosMedidasFormState(guias: [], personaJuridica: true));

  final TextEditingController registroController = TextEditingController();
  final TextEditingController nombreEmpresaController = TextEditingController();
  final TextEditingController nombreRepresentanteController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  final TextEditingController rucController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController distritoController = TextEditingController();
  final TextEditingController provinciaController = TextEditingController();
  final TextEditingController departamentoController = TextEditingController();
  final TextEditingController tipoMercanciaController = TextEditingController();
  final TextEditingController tipoControlController = TextEditingController();
  final TextEditingController placasController = TextEditingController();
  final TextEditingController largoController = TextEditingController();
  final TextEditingController anchoController = TextEditingController();
  final TextEditingController altoController = TextEditingController();
  final TextEditingController configuracionVehicularController = TextEditingController();
  final TextEditingController pesoBrutoMaximoController = TextEditingController();
  final TextEditingController pesoTransportadoController = TextEditingController();
  final TextEditingController pbMaxNoControlController = TextEditingController();
  final TextEditingController pbMaxConBonificacionController = TextEditingController();
  final TextEditingController observacionesController = TextEditingController();
  final TextEditingController cjto1Controller = TextEditingController();
  final TextEditingController cjto2Controller = TextEditingController();
  final TextEditingController cjto3Controller = TextEditingController();
  final TextEditingController cjto4Controller = TextEditingController();
  final TextEditingController cjto5Controller = TextEditingController();
  final TextEditingController cjto6Controller = TextEditingController();

  final TextEditingController numeroDeGuiaController = TextEditingController();

  final TextEditingController placas1TextController = TextEditingController();
  final TextEditingController placas2TextController = TextEditingController();
  final TextEditingController placas3TextController = TextEditingController();

  void setSignatureUrl(String signatureUrl) {
    emit(state.copyWith(signatureUrl: signatureUrl));
  }

  void personaJuridicaChanged() {
    emit(state.copyWith(personaJuridica: !state.personaJuridica!));
  }

  void fechaChanged(DateTime value) {
    final fecha = Fecha.dirty(value);
    emit(state.copyWith(
      fecha: fecha,
      isValidate: Formz.validate([fecha, ...state.getInputs()]),
    ));
  }

  void registroChanged(String value) {
    final registro = Registro.dirty(value);
    emit(state.copyWith(
      registro: registro,
      isValidate: Formz.validate([registro, ...state.getInputs()]),
    ));
  }

  void nombreEmpresaChanged(String value) {
    final nombreEmpresa = NombreEmpresa.dirty(value);
    emit(state.copyWith(
      nombreEmpresa: nombreEmpresa,
      isValidate: Formz.validate([nombreEmpresa, ...state.getInputs()]),
    ));
  }

  void nombreRepresentanteChanged(String value) {
    final nombreRepresentante = NombreRepresentante.dirty(value);
    emit(state.copyWith(
      nombreRepresentante: nombreRepresentante,
      isValidate: Formz.validate([nombreRepresentante, ...state.getInputs()]),
    ));
  }

  void rucChanged(String value) {
    final ruc = Ruc.dirty(value);
    emit(state.copyWith(
      ruc: ruc,
      isValidate: Formz.validate([ruc, ...state.getInputs()]),
    ));
  }

  void telefonoChanged(String value) {
    final telefono = Telefono.dirty(value);
    emit(state.copyWith(
      telefono: telefono,
      isValidate: Formz.validate([telefono, ...state.getInputs()]),
    ));
  }

  void direccionChanged(String value) {
    final direccion = Direccion.dirty(value);
    emit(state.copyWith(
      direccion: direccion,
      isValidate: Formz.validate([direccion, ...state.getInputs()]),
    ));
  }

  void distritoChanged(String value) {
    final distrito = Distrito.dirty(value);
    emit(state.copyWith(
      distrito: distrito,
      isValidate: Formz.validate([distrito, ...state.getInputs()]),
    ));
  }

  void provinciaChanged(String value) {
    final provincia = Provincia.dirty(value);
    emit(state.copyWith(
      provincia: provincia,
      isValidate: Formz.validate([provincia, ...state.getInputs()]),
    ));
  }

  void departamentoChanged(String value) {
    final departamento = Departamento.dirty(value);
    emit(state.copyWith(
      departamento: departamento,
      isValidate: Formz.validate([departamento, ...state.getInputs()]),
    ));
  }

  void tipoMercanciaChanged(String value) {
    final tipoMercancia = TipoMercancia.dirty(value);
    emit(state.copyWith(
      tipoMercancia: tipoMercancia,
      isValidate: Formz.validate([tipoMercancia, ...state.getInputs()]),
    ));
  }

  // void guiaRemisionChanged(String value) {
  //   final guiaRemision = GuiaRemision.dirty(value);
  //   emit(state.copyWith(
  //     guiaRemision: guiaRemision,
  //     isValidate: Formz.validate([guiaRemision, ...state.getInputs()]),
  //   ));
  // }

  void tipoControlChanged(String value) {
    final tipoControl = TipoControl.dirty(value);
    emit(state.copyWith(
      tipoControl: tipoControl,
      isValidate: Formz.validate([tipoControl, ...state.getInputs()]),
    ));
  }

  void placasChanged(String value) {
    final placas = Placas.dirty(value);
    emit(state.copyWith(
      placas: placas,
      isValidate: Formz.validate([placas, ...state.getInputs()]),
    ));
  }

  void largoChanged(String value) {
    final largo = Largo.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      largo: largo,
      isValidate: Formz.validate([largo, ...state.getInputs()]),
    ));
  }

  void anchoChanged(String value) {
    final ancho = Ancho.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      ancho: ancho,
      isValidate: Formz.validate([ancho, ...state.getInputs()]),
    ));
  }

  void altoChanged(String value) {
    final alto = Alto.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      alto: alto,
      isValidate: Formz.validate([alto, ...state.getInputs()]),
    ));
  }

  void configuracionVehicularChanged(String value) {
    final configuracionVehicular = ConfiguracionVehicular.dirty(value);
    emit(state.copyWith(
      configuracionVehicular: configuracionVehicular,
      isValidate: Formz.validate([configuracionVehicular, ...state.getInputs()]),
    ));
  }

  void deleteGuia(int index) {
    List<String> guias = List<String>.from(state.guias ?? [])..removeAt(index);
    emit(state.copyWith(guias: guias));
  }

  void agregarGuia() {
    List<String> guias = List<String>.from(state.guias ?? [])..add(numeroDeGuiaController.text);
    numeroDeGuiaController.text = '';
    emit(state.copyWith(guias: guias));
  }

  // void nombreGuiaChanged(int index, String value) {
  //   final guias = List<String>.from(state.guias ?? []);
  //   guias[index] = value;
  //   emit(state.copyWith(guias: guias));
  // }

  void pesoBrutoMaximoChanged(String value) {
    final pesoBrutoMaximo = PesoBrutoMaximo.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      pesoBrutoMaximo: pesoBrutoMaximo,
      isValidate: Formz.validate([pesoBrutoMaximo, ...state.getInputs()]),
    ));
  }

  void pesoTransportadoChanged(String value) {
    final pesoTransportado = PesoTransportado.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      pesoTransportado: pesoTransportado,
      isValidate: Formz.validate([pesoTransportado, ...state.getInputs()]),
    ));
  }

  void pbMaxNoControlChanged(String value) {
    final pbMaxNoControl = PbMaxNoControl.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      pbMaxNoControl: pbMaxNoControl,
      isValidate: Formz.validate([pbMaxNoControl, ...state.getInputs()]),
    ));
  }

  void pbMaxConBonificacionChanged(String value) {
    final pbMaxConBonificacion = PbMaxConBonificacion.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      pbMaxConBonificacion: pbMaxConBonificacion,
      isValidate: Formz.validate([pbMaxConBonificacion, ...state.getInputs()]),
    ));
  }

  void cjto1Changed(String value) {
    final cjto1 = CJTO1.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      cjto1: cjto1,
      isValidate: Formz.validate([cjto1, ...state.getInputs()]),
    ));
  }

  void cjto2Changed(String value) {
    final cjto2 = CJTO2.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      cjto2: cjto2,
      isValidate: Formz.validate([cjto2, ...state.getInputs()]),
    ));
  }

  void cjto3Changed(String value) {
    final cjto3 = CJTO3.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      cjto3: cjto3,
      isValidate: Formz.validate([cjto3, ...state.getInputs()]),
    ));
  }

  void cjto4Changed(String value) {
    final cjto4 = CJTO4.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      cjto4: cjto4,
      isValidate: Formz.validate([cjto4, ...state.getInputs()]),
    ));
  }

  void cjto5Changed(String value) {
    final cjto5 = CJTO5.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      cjto5: cjto5,
      isValidate: Formz.validate([cjto5, ...state.getInputs()]),
    ));
  }

  void cjto6Changed(String value) {
    final cjto6 = CJTO6.dirty(double.tryParse(value) ?? 0.0);
    emit(state.copyWith(
      cjto6: cjto6,
      isValidate: Formz.validate([cjto6, ...state.getInputs()]),
    ));
  }

  void observacionesChanged(String value) {
    final observaciones = Observaciones.dirty(value);
    emit(state.copyWith(
      observaciones: observaciones,
      isValidate: Formz.validate([observaciones, ...state.getInputs()]),
    ));
  }

  Future<void> submitForm(String userId, String logoUrl) async {
    if (!state.isValidate) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final verificacion = VerificacionPesosMedidasModel(
          dni: dniController.text,
          userId: userId,
          logoUrl: logoUrl,
          personaJuridica: state.personaJuridica,
          fecha: state.fecha.value,
          registro: state.registro.value,
          nombreEmpresa: state.nombreEmpresa.value,
          ruc: state.ruc.value,
          telefono: state.telefono.value,
          direccion: state.direccion.value,
          distrito: state.distrito.value,
          provincia: state.provincia.value,
          departamento: state.departamento.value,
          tipoMercancia: state.tipoMercancia.value,
          tipoControl: state.tipoControl.value,
          largo: state.largo.value,
          ancho: state.ancho.value,
          alto: state.alto.value,
          configuracionVehicular: state.configuracionVehicular.value,
          pesoBrutoMaximo: state.pesoBrutoMaximo.value,
          pesoTransportado: state.pesoTransportado.value,
          pbMaxNoControl: state.pbMaxNoControl.value,
          pbMaxConBonificacion: state.pbMaxConBonificacion.value,
          observaciones: state.observaciones.value,
          signatureUrl: state.signatureUrl,
          cjto1: state.cjto1.value,
          cjto2: state.cjto2.value,
          cjto3: state.cjto3.value,
          cjto4: state.cjto4.value,
          cjto5: state.cjto5.value,
          cjto6: state.cjto6.value,
          guias: state.guias,
          nombreRepresentante: state.nombreRepresentante.value,
          version: 1,
          placas1: placas1TextController.text,
          placas2: placas2TextController.text,
          placas3: placas3TextController.text);
      // //! --- verify wifi
      final internetConnection = await hasInternetConnection();
      if (internetConnection) {
        await _repository.createVerificacion(verificacion.copyWith());
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        await _localFormsRepository.saveVerificacionLocally(verificacion);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> editForm(VerificacionPesosMedidasModel verificationModel) async {
    // if (!state.isValidate) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      int versionUpdated = verificationModel.version! + 1;
      final verificacion = verificationModel.copyWith(
        dni: dniController.text,
        personaJuridica: state.personaJuridica,
        fecha: state.fecha.value,
        registro: state.registro.value,
        nombreEmpresa: state.nombreEmpresa.value,
        ruc: state.ruc.value,
        telefono: state.telefono.value,
        direccion: state.direccion.value,
        distrito: state.distrito.value,
        provincia: state.provincia.value,
        departamento: state.departamento.value,
        tipoMercancia: state.tipoMercancia.value,
        tipoControl: state.tipoControl.value,
        placas: state.placas.value,
        largo: state.largo.value,
        ancho: state.ancho.value,
        alto: state.alto.value,
        configuracionVehicular: state.configuracionVehicular.value,
        pesoBrutoMaximo: state.pesoBrutoMaximo.value,
        pesoTransportado: state.pesoTransportado.value,
        pbMaxNoControl: state.pbMaxNoControl.value,
        pbMaxConBonificacion: state.pbMaxConBonificacion.value,
        observaciones: state.observaciones.value,
        signatureUrl: state.signatureUrl,
        cjto1: state.cjto1.value,
        cjto2: state.cjto2.value,
        cjto3: state.cjto3.value,
        cjto4: state.cjto4.value,
        cjto5: state.cjto5.value,
        cjto6: state.cjto6.value,
        guias: state.guias,
        version: versionUpdated,
        nombreRepresentante: state.nombreRepresentante.value,
        placas1: placas1TextController.text,
        placas2: placas2TextController.text,
        placas3: placas3TextController.text,
      );
      // //! --- verify wifi
      final internetConnection = await hasInternetConnection();
      if (internetConnection) {
        await _repository.createVerificacion(verificacion);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        await _localFormsRepository.saveVerificacionLocally(verificacion);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> initEditForm(VerificacionPesosMedidasModel? verificationModel) async {
    if (verificationModel != null) {
      dniController.text = verificationModel.dni ?? '';
      registroController.text = verificationModel.registro ?? '';
      nombreEmpresaController.text = verificationModel.nombreEmpresa ?? '';
      rucController.text = verificationModel.ruc ?? '';
      telefonoController.text = verificationModel.telefono ?? '';
      direccionController.text = verificationModel.direccion ?? '';
      distritoController.text = verificationModel.distrito ?? '';
      provinciaController.text = verificationModel.provincia ?? '';
      departamentoController.text = verificationModel.departamento ?? '';
      tipoMercanciaController.text = verificationModel.tipoMercancia ?? '';
      tipoControlController.text = verificationModel.tipoControl ?? '';
      largoController.text = verificationModel.largo?.toString() ?? '0';
      anchoController.text = verificationModel.ancho?.toString() ?? '0';
      altoController.text = verificationModel.alto?.toString() ?? '0';
      configuracionVehicularController.text = verificationModel.configuracionVehicular ?? '';
      pesoBrutoMaximoController.text = verificationModel.pesoBrutoMaximo?.toString() ?? '0';
      pesoTransportadoController.text = verificationModel.pesoTransportado?.toString() ?? '0';
      pbMaxNoControlController.text = verificationModel.pbMaxNoControl?.toString() ?? '0';
      pbMaxConBonificacionController.text = verificationModel.pbMaxConBonificacion?.toString() ?? '0';
      observacionesController.text = verificationModel.observaciones ?? '';
      cjto1Controller.text = verificationModel.cjto1?.toString() ?? '0';
      cjto2Controller.text = verificationModel.cjto2?.toString() ?? '0';
      cjto3Controller.text = verificationModel.cjto3?.toString() ?? '0';
      cjto4Controller.text = verificationModel.cjto4?.toString() ?? '0';
      cjto5Controller.text = verificationModel.cjto5?.toString() ?? '0';
      cjto6Controller.text = verificationModel.cjto6?.toString() ?? '0';
      nombreRepresentanteController.text = verificationModel.nombreRepresentante ?? '';
      placas1TextController.text = verificationModel.placas1 ?? '';
      placas2TextController.text = verificationModel.placas2 ?? '';
      placas3TextController.text = verificationModel.placas3 ?? '';

      emit(state.copyWith(
        dni: dniController.text,
        fecha: Fecha.dirty(verificationModel.fecha),
        registro: Registro.dirty(verificationModel.registro ?? ''),
        nombreEmpresa: NombreEmpresa.dirty(verificationModel.nombreEmpresa ?? ''),
        ruc: Ruc.dirty(verificationModel.ruc ?? ''),
        telefono: Telefono.dirty(verificationModel.telefono ?? ''),
        direccion: Direccion.dirty(verificationModel.direccion ?? ''),
        distrito: Distrito.dirty(verificationModel.distrito ?? ''),
        provincia: Provincia.dirty(verificationModel.provincia ?? ''),
        departamento: Departamento.dirty(verificationModel.departamento ?? ''),
        tipoMercancia: TipoMercancia.dirty(verificationModel.tipoMercancia ?? ''),
        tipoControl: TipoControl.dirty(verificationModel.tipoControl ?? ''),
        largo: Largo.dirty(verificationModel.largo ?? 0),
        ancho: Ancho.dirty(verificationModel.ancho ?? 0),
        alto: Alto.dirty(verificationModel.alto ?? 0),
        configuracionVehicular: ConfiguracionVehicular.dirty(verificationModel.configuracionVehicular ?? ''),
        pesoBrutoMaximo: PesoBrutoMaximo.dirty(verificationModel.pesoBrutoMaximo ?? 0),
        pesoTransportado: PesoTransportado.dirty(verificationModel.pesoTransportado ?? 0),
        pbMaxNoControl: PbMaxNoControl.dirty(verificationModel.pbMaxNoControl ?? 0),
        pbMaxConBonificacion: PbMaxConBonificacion.dirty(verificationModel.pbMaxConBonificacion ?? 0),
        observaciones: Observaciones.dirty(verificationModel.observaciones ?? ''),
        signatureUrl: verificationModel.signatureUrl,
        cjto1: CJTO1.dirty(verificationModel.cjto1 ?? 0),
        cjto2: CJTO2.dirty(verificationModel.cjto2 ?? 0),
        cjto3: CJTO3.dirty(verificationModel.cjto3 ?? 0),
        cjto4: CJTO4.dirty(verificationModel.cjto4 ?? 0),
        cjto5: CJTO5.dirty(verificationModel.cjto5 ?? 0),
        cjto6: CJTO6.dirty(verificationModel.cjto6 ?? 0),
        guias: verificationModel.guias ?? [],
        nombreRepresentante: NombreRepresentante.dirty(verificationModel.nombreRepresentante ?? ''),
        personaJuridica: verificationModel.personaJuridica ?? false,
      ));
    }
  }

  Future<void> deleteForm(String id) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _repository.deleteVerificacion(id);
      emit(state.copyWith(status: FormzSubmissionStatus.success, message: 'Se eliminó correctamente la guía'));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Hubo un error $e'));
    }
  }
}
