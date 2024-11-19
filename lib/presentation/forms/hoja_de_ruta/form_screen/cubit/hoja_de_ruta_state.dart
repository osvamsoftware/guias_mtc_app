part of 'hoja_de_ruta_cubit.dart';

class HojaDeRutaFormState extends Equatable {
  final Folio folio;
  final Telefono telefono;
  final RazonSocial razonSocial;
  final CorreoElectronico correoElectronico;
  final NumeroPlaca numeroPlaca;
  final FechaInicioViaje fechaInicioViaje;
  final FechaLlegadaViaje fechaLlegadaViaje;
  final Ruta ruta;
  final ModalidadServicio modalidadServicio;
  final TerminalSalida terminalSalida;
  final TerminalLlegada terminalLlegada;
  final EscalasComerciales escalasComerciales;
  final HoraSalida horaSalida;
  final HoraLlegada horaLlegada;
  final List<Conductor> conductores;
  final String? signaturePath;
  final RucField rucField;
  final NumPasajeros numPasajeros;
  final Distrito distritoDestino;
  final Provincia provinciaDestino;
  final Departamento departamentoDestino;
  final Direccion direccionDestino;
  final Distrito distritoOrigen;
  final Provincia provinciaOrigen;
  final Departamento departamentoOrigen;
  final Direccion direccionOrigen;
  // final Placas placas;
  final Estado estado;
  final RevisionTecnica revisionTecnica;
  final SOAT soat;

  final FormzSubmissionStatus status;
  final bool isValidate;
  final String message;
  final List<Itinerario> itinerarioList;
  final DateTime? fechaHoraIncidencia;
  final DateTime? horaInicio;
  final DateTime? horaTermino;

  HojaDeRutaFormState({
    this.telefono = const Telefono.pure(),
    this.folio = const Folio.pure(),
    this.razonSocial = const RazonSocial.pure(),
    this.correoElectronico = const CorreoElectronico.pure(),
    this.numeroPlaca = const NumeroPlaca.pure(),
    this.fechaInicioViaje = const FechaInicioViaje.pure(),
    this.fechaLlegadaViaje = const FechaLlegadaViaje.pure(),
    this.ruta = const Ruta.pure(),
    this.modalidadServicio = const ModalidadServicio.pure(),
    this.terminalSalida = const TerminalSalida.pure(),
    this.terminalLlegada = const TerminalLlegada.pure(),
    this.escalasComerciales = const EscalasComerciales.pure(),
    this.horaSalida = const HoraSalida.pure(),
    this.horaLlegada = const HoraLlegada.pure(),
    this.conductores = const [],
    this.status = FormzSubmissionStatus.initial,
    this.isValidate = false,
    this.message = '',
    this.signaturePath,
    this.rucField = const RucField.pure(),
    this.numPasajeros = const NumPasajeros.pure(),
    // this.placas = const Placas.pure(),
    this.estado = const Estado.pure(),
    this.revisionTecnica = const RevisionTecnica.pure(),
    this.soat = const SOAT.pure(),
    this.distritoDestino = const Distrito.pure(),
    this.provinciaDestino = const Provincia.pure(),
    this.departamentoDestino = const Departamento.pure(),
    this.direccionDestino = const Direccion.pure(),
    this.distritoOrigen = const Distrito.pure(),
    this.provinciaOrigen = const Provincia.pure(),
    this.departamentoOrigen = const Departamento.pure(),
    this.direccionOrigen = const Direccion.pure(),
    this.itinerarioList = const [],
    this.fechaHoraIncidencia,
    this.horaInicio,
    this.horaTermino,
  });

  HojaDeRutaFormState copyWith({
    Folio? folio,
    Telefono? telefono,
    RazonSocial? razonSocial,
    CorreoElectronico? correoElectronico,
    NumeroPlaca? numeroPlaca,
    FechaInicioViaje? fechaInicioViaje,
    FechaLlegadaViaje? fechaLlegadaViaje,
    Ruta? ruta,
    ModalidadServicio? modalidadServicio,
    TerminalSalida? terminalSalida,
    TerminalLlegada? terminalLlegada,
    EscalasComerciales? escalasComerciales,
    HoraSalida? horaSalida,
    HoraLlegada? horaLlegada,
    List<Conductor>? conductores,
    String? signaturePath,
    RucField? rucField,
    NumPasajeros? numPasajeros,
    Estado? estado,
    RevisionTecnica? revisionTecnica,
    SOAT? soat,
    Distrito? distritoDestino,
    Provincia? provinciaDestino,
    Departamento? departamentoDestino,
    Direccion? direccionDestino,
    Distrito? distritoOrigen,
    Provincia? provinciaOrigen,
    Departamento? departamentoOrigen,
    Direccion? direccionOrigen,
    // Campos para el Conductor
    NombreConductor? nombreConductor,
    LicenciaConducir? licenciaConducir,
    HoraInicioConduccion? horaInicioConduccion,
    HoraTerminoConduccion? horaTerminoConduccion,
    TurnoConduccion? turnoConduccion,
    DescripcionIncidencia? descripcionIncidencia,
    LugarIncidencia? lugarIncidencia,
    FormzSubmissionStatus? status,
    bool? isValidate,
    String? message,
    List<Itinerario>? itinerarioList,
    DateTime? fechaHoraIncidencia,
    DateTime? horaInicio,
    DateTime? horaTermino,
  }) {
    return HojaDeRutaFormState(
      signaturePath: signaturePath ?? this.signaturePath,
      rucField: rucField ?? this.rucField,
      numPasajeros: numPasajeros ?? this.numPasajeros,
      // placas: placas ?? this.placas,
      estado: estado ?? this.estado,
      revisionTecnica: revisionTecnica ?? this.revisionTecnica,
      soat: soat ?? this.soat,
      conductores: conductores ?? this.conductores,
      telefono: telefono ?? this.telefono,
      folio: folio ?? this.folio,
      razonSocial: razonSocial ?? this.razonSocial,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      numeroPlaca: numeroPlaca ?? this.numeroPlaca,
      fechaInicioViaje: fechaInicioViaje ?? this.fechaInicioViaje,
      fechaLlegadaViaje: fechaLlegadaViaje ?? this.fechaLlegadaViaje,
      ruta: ruta ?? this.ruta,
      modalidadServicio: modalidadServicio ?? this.modalidadServicio,
      terminalSalida: terminalSalida ?? this.terminalSalida,
      terminalLlegada: terminalLlegada ?? this.terminalLlegada,
      escalasComerciales: escalasComerciales ?? this.escalasComerciales,
      horaSalida: horaSalida ?? this.horaSalida,
      horaLlegada: horaLlegada ?? this.horaLlegada,
      status: status ?? this.status,
      isValidate: isValidate ?? this.isValidate,
      message: message ?? this.message,
      distritoDestino: distritoDestino ?? this.distritoDestino,
      provinciaDestino: provinciaDestino ?? this.provinciaDestino,
      departamentoDestino: departamentoDestino ?? this.departamentoDestino,
      direccionDestino: direccionDestino ?? this.direccionDestino,
      distritoOrigen: distritoOrigen ?? this.distritoOrigen,
      provinciaOrigen: provinciaOrigen ?? this.provinciaOrigen,
      departamentoOrigen: departamentoOrigen ?? this.departamentoOrigen,
      direccionOrigen: direccionOrigen ?? this.direccionOrigen,
      itinerarioList: itinerarioList ?? this.itinerarioList,
      fechaHoraIncidencia: fechaHoraIncidencia ?? this.fechaHoraIncidencia,
      horaInicio: horaInicio ?? this.horaInicio,
      horaTermino: horaTermino ?? this.horaTermino,
    );
  }

  @override
  List<Object> get props => [
        rucField,
        numPasajeros,
        // placas,
        estado,
        revisionTecnica,
        soat,
        folio,
        telefono,
        razonSocial,
        correoElectronico,
        numeroPlaca,
        fechaInicioViaje,
        fechaLlegadaViaje,
        ruta,
        modalidadServicio,
        terminalSalida,
        terminalLlegada,
        escalasComerciales,
        horaSalida,
        horaLlegada,
        conductores,
        status,
        isValidate,
        message,
        signaturePath ?? '',
        distritoDestino,
        provinciaDestino,
        departamentoDestino,
        direccionDestino,
        distritoOrigen,
        provinciaOrigen,
        departamentoOrigen,
        direccionOrigen,
        itinerarioList,
        fechaHoraIncidencia ?? '',
        horaInicio ?? '',
        horaTermino ?? '',
      ];

  List<FormzInput> getInputs() {
    return [
      folio,
      // telefono,
      razonSocial,
      // correoElectronico,
      // numeroPlaca,
      fechaInicioViaje,
      fechaLlegadaViaje,
      // ruta,
      modalidadServicio,
      // terminalSalida,
      // terminalLlegada,
      // escalasComerciales,
      horaSalida,
      horaLlegada,
      rucField,
      numPasajeros,
      // placas,
      estado,
      revisionTecnica,
      soat,
      distritoDestino,
      provinciaDestino,
      departamentoDestino,
      // direccionDestino,
      distritoOrigen,
      provinciaOrigen,
      departamentoOrigen,
      // direccionOrigen,
    ];
  }
}
