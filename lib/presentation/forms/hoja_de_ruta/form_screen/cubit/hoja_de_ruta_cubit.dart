import 'package:app_remision/core/helpers/signature/connectivity/wifi_settings.dart';
import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/form_screen/fields.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'hoja_de_ruta_state.dart';

class HojaDeRutaCubit extends Cubit<HojaDeRutaFormState> {
  final HojaDeRutaRepository _repository;
  final LocalFormsRepository _localFormsRepository;

  //! -----
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController fechaInicioViajeController = TextEditingController();
  final TextEditingController fechaLlegadaViajeController = TextEditingController();
  final TextEditingController horaSalidaController = TextEditingController();
  final TextEditingController horaLlegadaController = TextEditingController();
  final TextEditingController horaInicioConduccionController = TextEditingController();
  final TextEditingController horaFinConduccionController = TextEditingController();
  final TextEditingController fechaHoraIncidenciaController = TextEditingController();
  final TextEditingController folioController = TextEditingController();
  final TextEditingController razonSocialController = TextEditingController();
  final TextEditingController direccionOrigenController = TextEditingController();
  final TextEditingController direccionDestinoController = TextEditingController();
  final TextEditingController correoElectronicoController = TextEditingController();
  final TextEditingController numeroPlacaController = TextEditingController();
  final TextEditingController rutaController = TextEditingController();
  final TextEditingController modalidadServicioController = TextEditingController();
  final TextEditingController terminalSalidaController = TextEditingController();
  final TextEditingController terminalLlegadaController = TextEditingController();
  final TextEditingController escalasComercialesController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController rucController = TextEditingController();
  final TextEditingController numPasajerosController = TextEditingController();
  final TextEditingController distritoDestinoController = TextEditingController();
  final TextEditingController provinciaDestinoController = TextEditingController();
  final TextEditingController departamentoDestinoController = TextEditingController();
  final TextEditingController distritoOrigenController = TextEditingController();
  final TextEditingController provinciaOrigenController = TextEditingController();
  final TextEditingController departamentoOrigenController = TextEditingController();
  final TextEditingController placasController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController revisionTecnicaController = TextEditingController();
  final TextEditingController soatController = TextEditingController();

  final TextEditingController distritoItinerarioController = TextEditingController();
  final TextEditingController provinciaItinerarioController = TextEditingController();
  final TextEditingController departamentoItinerarioController = TextEditingController();

  final TextEditingController nombreConductorController = TextEditingController();
  final TextEditingController licenciaConducirController = TextEditingController();
  final TextEditingController turnoConduccionController = TextEditingController();
  final TextEditingController descripcionIncidenciaController = TextEditingController();
  final TextEditingController lugarIncidenciaController = TextEditingController();

  //! -----
  //! -----

  HojaDeRutaCubit(this._repository, this._localFormsRepository) : super(HojaDeRutaFormState(itinerarioList: const []));

  void setSignatureUrl(String signatureUrl) {
    emit(state.copyWith(signaturePath: signatureUrl));
  }

  // Métodos para cambiar cada campo del formulario

  void folioChanged(String value) {
    final folio = Folio.dirty(value);
    emit(state.copyWith(
      folio: folio,
      isValidate: Formz.validate([...state.getInputs(), folio]),
    ));
  }

  void telefonoChanged(String value) {
    final telefono = Telefono.dirty(value);
    emit(state.copyWith(
      telefono: telefono,
      isValidate: Formz.validate([...state.getInputs(), telefono]),
    ));
  }

  void razonSocialChanged(String value) {
    final razonSocial = RazonSocial.dirty(value);
    emit(state.copyWith(
      razonSocial: razonSocial,
      isValidate: Formz.validate([...state.getInputs(), razonSocial]),
    ));
  }

  void correoElectronicoChanged(String value) {
    final correoElectronico = CorreoElectronico.dirty(value);
    emit(state.copyWith(
      correoElectronico: correoElectronico,
      isValidate: Formz.validate([...state.getInputs(), correoElectronico]),
    ));
  }

  void numeroPlacaChanged(String value) {
    final numeroPlaca = NumeroPlaca.dirty(value);
    emit(state.copyWith(
      numeroPlaca: numeroPlaca,
      isValidate: Formz.validate([...state.getInputs(), numeroPlaca]),
    ));
  }

  void rutaChanged(String value) {
    final ruta = Ruta.dirty(value);
    emit(state.copyWith(
      ruta: ruta,
      isValidate: Formz.validate([...state.getInputs(), ruta]),
    ));
  }

  void modalidadServicioChanged(String value) {
    final modalidadServicio = ModalidadServicio.dirty(value);
    emit(state.copyWith(
      modalidadServicio: modalidadServicio,
      isValidate: Formz.validate([...state.getInputs(), modalidadServicio]),
    ));
  }

  void terminalSalidaChanged(String value) {
    final terminalSalida = TerminalSalida.dirty(value);
    emit(state.copyWith(
      terminalSalida: terminalSalida,
      isValidate: Formz.validate([...state.getInputs(), terminalSalida]),
    ));
  }

  void terminalLlegadaChanged(String value) {
    final terminalLlegada = TerminalLlegada.dirty(value);
    emit(state.copyWith(
      terminalLlegada: terminalLlegada,
      isValidate: Formz.validate([...state.getInputs(), terminalLlegada]),
    ));
  }

  void escalasComercialesChanged(String value) {
    final escalasComerciales = EscalasComerciales.dirty(value);
    emit(state.copyWith(
      escalasComerciales: escalasComerciales,
      isValidate: Formz.validate([...state.getInputs(), escalasComerciales]),
    ));
  }

  void distritoOrigenChanged(String value) {
    final distritoOrigen = Distrito.dirty(value);
    emit(state.copyWith(
      distritoOrigen: distritoOrigen,
      isValidate: Formz.validate([distritoOrigen, ...state.getInputs()]),
    ));
  }

  void provinciaOrigenChanged(String value) {
    final provinciaOrigen = Provincia.dirty(value);
    emit(state.copyWith(
      provinciaOrigen: provinciaOrigen,
      isValidate: Formz.validate([provinciaOrigen, ...state.getInputs()]),
    ));
  }

  void departamentoOrigenChanged(String value) {
    final departamentoOrigen = Departamento.dirty(value);
    emit(state.copyWith(
      departamentoOrigen: departamentoOrigen,
      isValidate: Formz.validate([departamentoOrigen, ...state.getInputs()]),
    ));
  }

  void distritoDestinoChanged(String value) {
    final distritoDestino = Distrito.dirty(value);
    emit(state.copyWith(
      distritoDestino: distritoDestino,
      isValidate: Formz.validate([distritoDestino, ...state.getInputs()]),
    ));
  }

  void provinciaDestinoChanged(String value) {
    final provinciaDestino = Provincia.dirty(value);
    emit(state.copyWith(
      provinciaDestino: provinciaDestino,
      isValidate: Formz.validate([provinciaDestino, ...state.getInputs()]),
    ));
  }

  void departamentoDestinoChanged(String value) {
    final departamentoDestino = Departamento.dirty(value);
    emit(state.copyWith(
      departamentoDestino: departamentoDestino,
      isValidate: Formz.validate([departamentoDestino, ...state.getInputs()]),
    ));
  }

  void direccionOrigenChanged(String value) {
    final direccionOrigen = Direccion.dirty(value);
    emit(state.copyWith(
      direccionOrigen: direccionOrigen,
      isValidate: Formz.validate([direccionOrigen, ...state.getInputs()]),
    ));
  }

  void direccionDestinoChanged(String value) {
    final direccionDestino = Direccion.dirty(value);
    emit(state.copyWith(
      direccionDestino: direccionDestino,
      isValidate: Formz.validate([direccionDestino, ...state.getInputs()]),
    ));
  }

  void placasChanged(String value) {
    final placas = NumeroPlaca.dirty(value);
    emit(state.copyWith(
      numeroPlaca: placas,
      isValidate: Formz.validate([placas, ...state.getInputs()]),
    ));
  }

  void estadoChanged(String value) {
    final estado = Estado.dirty(value);
    emit(state.copyWith(
      estado: estado,
      isValidate: Formz.validate([estado, ...state.getInputs()]),
    ));
  }

  void revisionTecnicaChanged(String value) {
    final revisionTecnica = RevisionTecnica.dirty(value);
    emit(state.copyWith(
      revisionTecnica: revisionTecnica,
      isValidate: Formz.validate([revisionTecnica, ...state.getInputs()]),
    ));
  }

  void soatChanged(String value) {
    final soat = SOAT.dirty(value);
    emit(state.copyWith(
      soat: soat,
      isValidate: Formz.validate([soat, ...state.getInputs()]),
    ));
  }

  void rucChanged(String value) {
    final ruc = RucField.dirty(value);
    emit(state.copyWith(
      rucField: ruc,
      isValidate: Formz.validate([ruc, ...state.getInputs()]),
    ));
  }

  void numPasajerosChanged(int value) {
    final numPasajeros = NumPasajeros.dirty(value);
    emit(state.copyWith(
      numPasajeros: numPasajeros,
      isValidate: Formz.validate([numPasajeros, ...state.getInputs()]),
    ));
  }

//! -------- CONDUCTOR
  void agregarConductor() {
    final conductores = List<Conductor>.from(state.conductores)
      ..add(Conductor(
        nombre: nombreConductorController.text,
        licenciaConducir: licenciaConducirController.text,
        incidencia: Incidencia(
            fechaHora: state.fechaHoraIncidencia,
            descripcion: descripcionIncidenciaController.text,
            lugar: lugarIncidenciaController.text),
        horaInicio: state.horaInicio,
        horaTermino: state.horaTermino,
        turnoConduccion: turnoConduccionController.text,
      ));
    nombreConductorController.clear();
    licenciaConducirController.clear();
    turnoConduccionController.clear();
    descripcionIncidenciaController.clear();
    lugarIncidenciaController.clear();

    emit(state.copyWith(
        conductores: conductores,
        isValidate: Formz.validate(state.getInputs()),
        fechaHoraIncidencia: null,
        horaInicio: null,
        horaTermino: null));
  }

  void deleteConductor(int index) {
    final conductores = List<Conductor>.from(state.conductores)..removeAt(index);
    emit(state.copyWith(conductores: conductores, isValidate: Formz.validate(state.getInputs())));
  }

  void horaInicioConduccionChanged(DateTime value) {
    emit(state.copyWith(horaInicio: value));
  }

  void horaFinConduccionChanged(DateTime value) {
    emit(state.copyWith(horaTermino: value));
  }

  void fechaHoraIncidenciaChanged(DateTime value) {
    emit(state.copyWith(fechaHoraIncidencia: value));
  }

//! -------- ITINERARIO

  void agregarItinerario() {
    final itinerario = List<Itinerario>.from(state.itinerarioList)
      ..add(Itinerario(
        distrito: distritoItinerarioController.text,
        provincia: provinciaItinerarioController.text,
        departamento: departamentoItinerarioController.text,
      ));
    distritoItinerarioController.clear();
    provinciaItinerarioController.clear();
    departamentoItinerarioController.clear();
    emit(state.copyWith(itinerarioList: itinerario, isValidate: Formz.validate(state.getInputs())));
  }

  void deleteItinerario(int index) {
    final itinerario = List<Itinerario>.from(state.itinerarioList)..removeAt(index);
    emit(state.copyWith(itinerarioList: itinerario, isValidate: Formz.validate(state.getInputs())));
  }

  //!! ---------------- datetime functions
  // Métodos para cambiar cada campo del formulario
  void fechaInicioViajeChanged(DateTime value) {
    final fechaInicioViaje = FechaInicioViaje.dirty(value);
    fechaInicioViajeController.text = value.toLocal().toString().split(' ')[0]; // Actualiza el controlador
    emit(state.copyWith(
      fechaInicioViaje: fechaInicioViaje,
      isValidate: Formz.validate([...state.getInputs(), fechaInicioViaje]),
    ));
  }

  void fechaLlegadaViajeChanged(DateTime value) {
    final fechaLlegadaViaje = FechaLlegadaViaje.dirty(value);
    fechaLlegadaViajeController.text = value.toLocal().toString().split(' ')[0]; // Actualiza el controlador
    emit(state.copyWith(
      fechaLlegadaViaje: fechaLlegadaViaje,
      isValidate: Formz.validate([...state.getInputs(), fechaLlegadaViaje]),
    ));
  }

  void horaSalidaChanged(DateTime value) {
    final horaSalida = HoraSalida.dirty(value);
    horaSalidaController.text = value.toLocal().toString().split(' ')[1].substring(0, 5); // Actualiza el controlador
    emit(state.copyWith(
      horaSalida: horaSalida,
      isValidate: Formz.validate([...state.getInputs(), horaSalida]),
    ));
  }

  void horaLlegadaChanged(DateTime value) {
    final horaLlegada = HoraLlegada.dirty(value);
    horaLlegadaController.text = value.toLocal().toString().split(' ')[1].substring(0, 5); // Actualiza el controlador
    emit(state.copyWith(
      horaLlegada: horaLlegada,
      isValidate: Formz.validate([...state.getInputs(), horaLlegada]),
    ));
  }

  void verificarFormulario() {
    final inputs = state.getInputs();
    final validationMessages = <String>[];

    for (var input in inputs) {
      if (input.isValid) {
        null;
      } else {
        validationMessages.add('${input.runtimeType} no es válido: ${input.error}');
      }
    }

    emit(state.copyWith(isValidate: inputs.every((input) => input.isValid), message: validationMessages.join('\n')));
  }

  void initEditForm(HojaDeRutaModel? hojaDeRuta) {
    if (hojaDeRuta != null) {
      razonSocialController.text = hojaDeRuta.razonSocial ?? '';
      direccionOrigenController.text = hojaDeRuta.direccionOrigen ?? '';
      direccionDestinoController.text = hojaDeRuta.direccionDestino ?? '';
      correoElectronicoController.text = hojaDeRuta.correoElectronico ?? '';
      numeroPlacaController.text = hojaDeRuta.numeroPlaca ?? '';
      rutaController.text = hojaDeRuta.ruta ?? '';
      modalidadServicioController.text = hojaDeRuta.modalidadServicio ?? '';
      terminalSalidaController.text = hojaDeRuta.terminalSalida ?? '';
      terminalLlegadaController.text = hojaDeRuta.terminalLlegada ?? '';
      escalasComercialesController.text = hojaDeRuta.escalasComerciales ?? '';
      telefonoController.text = hojaDeRuta.telefono ?? '';
      rucController.text = hojaDeRuta.ruc ?? '';
      numPasajerosController.text = hojaDeRuta.numPasajeros?.toString() ?? '';
      distritoDestinoController.text = hojaDeRuta.distritoDestino ?? '';
      provinciaDestinoController.text = hojaDeRuta.provinciaDestino ?? '';
      departamentoDestinoController.text = hojaDeRuta.departamentoDestino ?? '';
      distritoOrigenController.text = hojaDeRuta.distritoOrigen ?? '';
      provinciaOrigenController.text = hojaDeRuta.provinciaOrigen ?? '';
      departamentoOrigenController.text = hojaDeRuta.departamentoOrigen ?? '';
      placasController.text = hojaDeRuta.numeroPlaca ?? '';
      estadoController.text = hojaDeRuta.estado ?? '';
      revisionTecnicaController.text = hojaDeRuta.revisionTecnica ?? '';
      soatController.text = hojaDeRuta.soat ?? '';
      folioController.text = hojaDeRuta.folio ?? '';
      fechaInicioViajeController.text = hojaDeRuta.fechaInicioViaje?.toLocal().toString().split(' ')[0] ?? '';
      fechaLlegadaViajeController.text = hojaDeRuta.fechaLlegadaViaje?.toLocal().toString().split(' ')[0] ?? '';
      horaSalidaController.text = hojaDeRuta.horaSalida?.toLocal().toString().split(' ')[1].substring(0, 5) ?? '';
      horaLlegadaController.text = hojaDeRuta.horaLlegada?.toLocal().toString().split(' ')[1].substring(0, 5) ?? '';
      direccionController.text = hojaDeRuta.direccion ?? '';
      emit(state.copyWith(
        telefono: Telefono.dirty(hojaDeRuta.telefono ?? ''),
        razonSocial: RazonSocial.dirty(hojaDeRuta.razonSocial ?? ''),
        correoElectronico: CorreoElectronico.dirty(hojaDeRuta.correoElectronico ?? ''),
        numeroPlaca: NumeroPlaca.dirty(hojaDeRuta.numeroPlaca ?? ''),
        fechaInicioViaje: FechaInicioViaje.dirty(hojaDeRuta.fechaInicioViaje),
        fechaLlegadaViaje: FechaLlegadaViaje.dirty(hojaDeRuta.fechaLlegadaViaje),
        ruta: Ruta.dirty(hojaDeRuta.ruta ?? ''),
        modalidadServicio: ModalidadServicio.dirty(hojaDeRuta.modalidadServicio ?? ''),
        terminalSalida: TerminalSalida.dirty(hojaDeRuta.terminalSalida ?? ''),
        terminalLlegada: TerminalLlegada.dirty(hojaDeRuta.terminalLlegada ?? ''),
        escalasComerciales: EscalasComerciales.dirty(hojaDeRuta.escalasComerciales ?? ''),
        rucField: RucField.dirty(hojaDeRuta.ruc ?? ''),
        numPasajeros: NumPasajeros.dirty(hojaDeRuta.numPasajeros ?? 0),
        estado: Estado.dirty(hojaDeRuta.estado ?? ''),
        revisionTecnica: RevisionTecnica.dirty(hojaDeRuta.revisionTecnica ?? ''),
        soat: SOAT.dirty(hojaDeRuta.soat ?? ''),
        distritoDestino: Distrito.dirty(hojaDeRuta.distritoDestino ?? ''),
        provinciaDestino: Provincia.dirty(hojaDeRuta.provinciaDestino ?? ''),
        departamentoDestino: Departamento.dirty(hojaDeRuta.departamentoDestino ?? ''),
        direccionDestino: Direccion.dirty(hojaDeRuta.direccionDestino ?? ''),
        distritoOrigen: Distrito.dirty(hojaDeRuta.distritoOrigen ?? ''),
        provinciaOrigen: Provincia.dirty(hojaDeRuta.provinciaOrigen ?? ''),
        departamentoOrigen: Departamento.dirty(hojaDeRuta.departamentoOrigen ?? ''),
        direccionOrigen: Direccion.dirty(hojaDeRuta.direccionOrigen ?? ''),
        conductores: hojaDeRuta.conductores ?? [],
        itinerarioList: hojaDeRuta.itinerarioList,
        horaSalida: HoraSalida.dirty(hojaDeRuta.horaSalida),
        horaLlegada: HoraLlegada.dirty(hojaDeRuta.horaLlegada),
        signaturePath: hojaDeRuta.signatureUrl,
        horaInicioConduccion: HoraInicioConduccion.dirty(hojaDeRuta.conductores?[0].horaInicio),
        horaTerminoConduccion: HoraTerminoConduccion.dirty(hojaDeRuta.conductores?[0].horaTermino),
        fechaHoraIncidencia: state.fechaHoraIncidencia,
        isValidate: Formz.validate(state.getInputs()),
        folio: Folio.dirty(hojaDeRuta.folio ?? ''),
      ));
    }
  }

  Future<void> editForm(HojaDeRutaModel hojaDeRuta) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    verificarFormulario();
    if (!state.isValidate) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return;
    }
    final newVersion = hojaDeRuta.version! + 1;
    try {
      final nuevaHojaRuta = hojaDeRuta.copyWith(
          version: newVersion,
          razonSocial: state.razonSocial.value,
          direccionDestino: state.direccionDestino.value,
          direccionOrigen: state.direccionOrigen.value,
          telefono: state.telefono.value,
          ruc: state.rucField.value,
          numPasajeros: state.numPasajeros.value,
          distritoDestino: state.distritoDestino.value,
          provinciaDestino: state.provinciaDestino.value,
          departamentoDestino: state.departamentoDestino.value,
          distritoOrigen: state.distritoOrigen.value,
          provinciaOrigen: state.provinciaOrigen.value,
          departamentoOrigen: state.departamentoOrigen.value,
          estado: state.estado.value,
          revisionTecnica: state.revisionTecnica.value,
          soat: state.soat.value,
          correoElectronico: state.correoElectronico.value,
          numeroPlaca: state.numeroPlaca.value,
          fechaInicioViaje: state.fechaInicioViaje.value,
          fechaLlegadaViaje: state.fechaLlegadaViaje.value,
          ruta: state.ruta.value,
          modalidadServicio: state.modalidadServicio.value,
          terminalSalida: state.terminalSalida.value,
          terminalLlegada: state.terminalLlegada.value,
          escalasComerciales: state.escalasComerciales.value,
          horaSalida: state.horaSalida.value,
          horaLlegada: state.horaLlegada.value,
          conductores: state.conductores,
          itinerarioList: state.itinerarioList,
          folio: state.folio.value,
          direccion: direccionController.text);

      //! --- verify wifi
      final internetConnection = await hasInternetConnection();
      if (internetConnection) {
        await _repository.createHojaDeRuta(nuevaHojaRuta);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        await _localFormsRepository.saveHojaDeRutaLocally(nuevaHojaRuta);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  Future<void> deleteForm(String id) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _repository.deleteHojaDeRuta(id);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  Future<void> submitForm(String userId) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    if (state.conductores.isEmpty) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Debe agregar al menos un conductor'));
      return;
    }
    if (state.itinerarioList.isEmpty) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Debe agregar al menos un itinerario'));
      return;
    }
    verificarFormulario();
    if (!state.isValidate) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return;
    }
    try {
      final hojaRuta = HojaDeRutaModel(
          version: 1,
          signatureUrl: state.signaturePath,
          userId: userId,
          razonSocial: state.razonSocial.value,
          direccionDestino: state.direccionDestino.value,
          direccionOrigen: state.direccionOrigen.value,
          telefono: state.telefono.value,
          ruc: state.rucField.value,
          numPasajeros: state.numPasajeros.value,
          distritoDestino: state.distritoDestino.value,
          provinciaDestino: state.provinciaDestino.value,
          departamentoDestino: state.departamentoDestino.value,
          distritoOrigen: state.distritoOrigen.value,
          provinciaOrigen: state.provinciaOrigen.value,
          departamentoOrigen: state.departamentoOrigen.value,
          // placas: state.placas.value,
          estado: state.estado.value,
          revisionTecnica: state.revisionTecnica.value,
          soat: state.soat.value,
          correoElectronico: state.correoElectronico.value,
          numeroPlaca: state.numeroPlaca.value,
          fechaInicioViaje: state.fechaInicioViaje.value,
          fechaLlegadaViaje: state.fechaLlegadaViaje.value,
          ruta: state.ruta.value,
          modalidadServicio: state.modalidadServicio.value,
          terminalSalida: state.terminalSalida.value,
          terminalLlegada: state.terminalLlegada.value,
          escalasComerciales: state.escalasComerciales.value,
          horaSalida: state.horaSalida.value,
          horaLlegada: state.horaLlegada.value,
          conductores: state.conductores,
          itinerarioList: state.itinerarioList,
          folio: state.folio.value,
          direccion: direccionController.text);

      //! --- verify wifi
      final internetConnection = await hasInternetConnection();
      if (internetConnection) {
        await _repository.createHojaDeRuta(hojaRuta);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        await _localFormsRepository.saveHojaDeRutaLocally(hojaRuta);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }
}
