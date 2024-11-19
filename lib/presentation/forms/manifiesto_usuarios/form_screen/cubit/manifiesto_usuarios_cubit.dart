import 'package:app_remision/core/helpers/signature/connectivity/wifi_settings.dart';
import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:app_remision/domain/repository/local_forms_repository.dart';
import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/form_screen/manifest_fields.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'manifiesto_usuarios_state.dart';

class ManifiestoCubit extends Cubit<ManifiestoFormState> {
  final ManifiestoRepository _repository;
  final LocalFormsRepository _localFormsRepository;

  //! ----- Controladores de texto
  final TextEditingController fechaViajeController = TextEditingController();
  final TextEditingController placaVehicularController = TextEditingController();

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController razonSocialController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController correoElectronicoController = TextEditingController();
  final TextEditingController rutaController = TextEditingController();
  final TextEditingController modalidadServicioController = TextEditingController();
  final TextEditingController signatureUrlController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();

  final TextEditingController nombrePasajeroController = TextEditingController();
  final TextEditingController documentoIdentidadPasajeroController = TextEditingController();
  final TextEditingController edadPasajeroController = TextEditingController();

  ManifiestoCubit(this._repository, this._localFormsRepository) : super(const ManifiestoFormState());

  void setSignatureUrl(String signatureUrl) {
    emit(state.copyWith(signatureUrl: signatureUrl));
  }

  void razonSocialChanged(String value) {
    final razonSocial = RazonSocial.dirty(value);
    emit(state.copyWith(
      razonSocial: razonSocial,
      isValidate: Formz.validate([...state.getInputs(), razonSocial]),
    ));
  }

  void direccionChanged(String value) {
    final direccion = Direccion.dirty(value);
    emit(state.copyWith(
      direccion: direccion,
      isValidate: Formz.validate([...state.getInputs(), direccion]),
    ));
  }

  void correoElectronicoChanged(String value) {
    final correoElectronico = CorreoElectronico.dirty(value);
    emit(state.copyWith(
      correoElectronico: correoElectronico,
      isValidate: Formz.validate([...state.getInputs(), correoElectronico]),
    ));
  }

  void telefonoChanged(String value) {
    final telefono = Telefono.dirty(value);
    emit(state.copyWith(
      telefono: telefono,
      isValidate: Formz.validate([...state.getInputs(), telefono]),
    ));
  }

  void fechaViajeChanged(DateTime value) {
    final fechaViaje = FechaViaje.dirty(value);
    fechaViajeController.text = value.toLocal().toString().split(' ')[0]; // Actualiza el controlador
    emit(state.copyWith(
      fechaViaje: fechaViaje,
      isValidate: Formz.validate([...state.getInputs(), fechaViaje]),
    ));
  }

  void placaVehicularChanged(String value) {
    final placaVehicular = PlacaVehicular.dirty(value);
    emit(state.copyWith(
      placaVehicular: placaVehicular,
      isValidate: Formz.validate([...state.getInputs(), placaVehicular]),
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

  void verificarFormulario() {
    final inputs = state.getInputs();
    final validationMessages = <String>[];

    for (var input in inputs) {
      if (input.isValid) {
        validationMessages.add('${input.runtimeType} es válido.');
      } else {
        validationMessages.add('${input.runtimeType} no es válido: ${input.error}');
      }
    }

    emit(state.copyWith(isValidate: inputs.every((input) => input.isValid), message: validationMessages.join('\n')));
  }

  //! -------- PASAJEROS

  void agregarPasajero() {
    final pasajeros = List<Pasajero>.from(state.pasajeros)
      ..add(Pasajero(
          apellidosNombres: nombrePasajeroController.text,
          documentoIdentidad: documentoIdentidadPasajeroController.text,
          edad: int.tryParse(edadPasajeroController.text) ?? 0));
    nombrePasajeroController.clear();
    documentoIdentidadPasajeroController.clear();
    edadPasajeroController.clear();
    emit(state.copyWith(pasajeros: pasajeros, isValidate: Formz.validate(state.getInputs())));
  }

  void deletePasajero(int index) {
    final pasajeros = List<Pasajero>.from(state.pasajeros)..removeAt(index);
    emit(state.copyWith(pasajeros: pasajeros, isValidate: Formz.validate(state.getInputs())));
  }

  void pasajerosChanged(List<Pasajero> pasajeros) {
    emit(state.copyWith(
      pasajeros: pasajeros,
      isValidate: Formz.validate(state.getInputs()),
    ));
  }

  Future<void> submitForm(String userId) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    verificarFormulario();

    if (!state.isValidate) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return;
    }

    try {
      final manifiesto = ManifiestoModel(
          userId: userId,
          razonSocial: state.razonSocial.value,
          direccion: state.direccion.value,
          correoElectronico: state.correoElectronico.value,
          telefono: state.telefono.value,
          fechaViaje: state.fechaViaje.value,
          placaVehicular: state.placaVehicular.value,
          ruta: state.ruta.value,
          modalidadServicio: state.modalidadServicio.value,
          pasajeros: state.pasajeros,
          signatureUrl: state.signatureUrl,
          version: 1);

//! --- verify wifi
      final internetConnection = await hasInternetConnection();
      if (internetConnection) {
        await _repository.createManifiesto(manifiesto);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        await _localFormsRepository.saveManifiestoLocally(manifiesto);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  void initEdit(ManifiestoModel? manifiestoModel) {
    if (manifiestoModel != null) {
      razonSocialController.text = manifiestoModel.razonSocial ?? '';
      direccionController.text = manifiestoModel.direccion ?? '';
      correoElectronicoController.text = manifiestoModel.correoElectronico ?? '';
      telefonoController.text = manifiestoModel.telefono ?? '';
      fechaViajeController.text = manifiestoModel.fechaViaje?.toLocal().toString().split(' ')[0] ?? '';
      placaVehicularController.text = manifiestoModel.placaVehicular ?? '';
      rutaController.text = manifiestoModel.ruta ?? '';
      modalidadServicioController.text = manifiestoModel.modalidadServicio ?? '';
      signatureUrlController.text = manifiestoModel.signatureUrl ?? '';
      logoUrlController.text = manifiestoModel.logoUrl ?? '';
      emit(state.copyWith(
          razonSocial: RazonSocial.dirty(manifiestoModel.razonSocial ?? ''),
          direccion: Direccion.dirty(manifiestoModel.direccion ?? ''),
          correoElectronico: CorreoElectronico.dirty(manifiestoModel.correoElectronico ?? ''),
          telefono: Telefono.dirty(manifiestoModel.telefono ?? ''),
          fechaViaje: FechaViaje.dirty(manifiestoModel.fechaViaje ?? DateTime.now()),
          placaVehicular: PlacaVehicular.dirty(manifiestoModel.placaVehicular ?? ''),
          ruta: Ruta.dirty(manifiestoModel.ruta ?? ''),
          modalidadServicio: ModalidadServicio.dirty(manifiestoModel.modalidadServicio ?? ''),
          signatureUrl: manifiestoModel.signatureUrl ?? '',
          pasajeros: manifiestoModel.pasajeros ?? []));
    }
  }

  Future<void> editForm(ManifiestoModel manifiestoModel) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    verificarFormulario();
    if (!state.isValidate) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return;
    }
    final version = manifiestoModel.version ?? 0;
    try {
      final updatedManifiesto = manifiestoModel.copyWith(
          razonSocial: state.razonSocial.value,
          direccion: state.direccion.value,
          correoElectronico: state.correoElectronico.value,
          telefono: state.telefono.value,
          fechaViaje: state.fechaViaje.value,
          placaVehicular: state.placaVehicular.value,
          ruta: state.ruta.value,
          modalidadServicio: state.modalidadServicio.value,
          pasajeros: state.pasajeros,
          signatureUrl: state.signatureUrl,
          version: version + 1);

//! --- verify wifi
      final internetConnection = await hasInternetConnection();
      if (internetConnection) {
        await _repository.createManifiesto(manifiestoModel);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        await _localFormsRepository.saveManifiestoLocally(manifiestoModel);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }

  Future<void> deleteForm(String id) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _repository.deleteManifiesto(id);
      emit(state.copyWith(status: FormzSubmissionStatus.success, message: 'Se eliminó el Manifiesto'));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.toString()));
    }
  }
}
