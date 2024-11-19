part of 'manifiesto_usuarios_cubit.dart';

class ManifiestoFormState extends Equatable {
  final RazonSocial razonSocial;
  final Direccion direccion;
  final Telefono telefono;
  final CorreoElectronico correoElectronico;
  final FechaViaje fechaViaje;
  final PlacaVehicular placaVehicular;
  final Ruta ruta;
  final ModalidadServicio modalidadServicio;
  final List<Pasajero> pasajeros;
  final String? signatureUrl;

  final FormzSubmissionStatus status;
  final bool isValidate;
  final String message;

  const ManifiestoFormState({
    this.razonSocial = const RazonSocial.pure(),
    this.direccion = const Direccion.pure(),
    this.telefono = const Telefono.pure(),
    this.correoElectronico = const CorreoElectronico.pure(),
    this.fechaViaje = const FechaViaje.pure(),
    this.placaVehicular = const PlacaVehicular.pure(),
    this.ruta = const Ruta.pure(),
    this.modalidadServicio = const ModalidadServicio.pure(),
    this.pasajeros = const [],
    this.status = FormzSubmissionStatus.initial,
    this.isValidate = false,
    this.message = '',
    this.signatureUrl,
  });

  ManifiestoFormState copyWith({
    RazonSocial? razonSocial,
    Direccion? direccion,
    Telefono? telefono,
    CorreoElectronico? correoElectronico,
    FechaViaje? fechaViaje,
    PlacaVehicular? placaVehicular,
    Ruta? ruta,
    ModalidadServicio? modalidadServicio,
    List<Pasajero>? pasajeros,
    FormzSubmissionStatus? status,
    bool? isValidate,
    String? message,
    String? signatureUrl,
  }) {
    return ManifiestoFormState(
      razonSocial: razonSocial ?? this.razonSocial,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      fechaViaje: fechaViaje ?? this.fechaViaje,
      placaVehicular: placaVehicular ?? this.placaVehicular,
      ruta: ruta ?? this.ruta,
      modalidadServicio: modalidadServicio ?? this.modalidadServicio,
      pasajeros: pasajeros ?? this.pasajeros,
      status: status ?? this.status,
      isValidate: isValidate ?? this.isValidate,
      message: message ?? this.message,
      signatureUrl: signatureUrl ?? this.signatureUrl,
    );
  }

  @override
  List<Object> get props => [
        razonSocial,
        direccion,
        telefono,
        correoElectronico,
        fechaViaje,
        placaVehicular,
        ruta,
        modalidadServicio,
        pasajeros,
        status,
        isValidate,
        message,
        signatureUrl ?? ''
      ];

  List<FormzInput> getInputs() {
    return [
      razonSocial,
      direccion,
      telefono,
      correoElectronico,
      fechaViaje,
      placaVehicular,
      ruta,
      modalidadServicio,
    ];
  }
}
