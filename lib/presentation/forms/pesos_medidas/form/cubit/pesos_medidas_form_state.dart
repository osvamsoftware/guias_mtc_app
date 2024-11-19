part of 'pesos_medidas_form_cubit.dart';

class PesosMedidasFormState extends Equatable {
  final Fecha fecha;
  final Registro registro;
  final NombreEmpresa nombreEmpresa;
  final Ruc ruc;
  final Telefono telefono;
  final Direccion direccion;
  final Distrito distrito;
  final Provincia provincia;
  final Departamento departamento;
  final TipoMercancia tipoMercancia;
  final TipoControl tipoControl;
  final Placas placas;
  final Largo largo;
  final Ancho ancho;
  final Alto alto;
  final CJTO1 cjto1;
  final CJTO2 cjto2;
  final CJTO3 cjto3;
  final CJTO4 cjto4;
  final CJTO5 cjto5;
  final CJTO6 cjto6;
  final ConfiguracionVehicular configuracionVehicular;
  final PesoBrutoMaximo pesoBrutoMaximo;
  final PesoTransportado pesoTransportado;
  final PbMaxNoControl pbMaxNoControl;
  final PbMaxConBonificacion pbMaxConBonificacion;
  final Observaciones observaciones;
  final FormzSubmissionStatus status;
  final bool isValidate;
  final String message;
  final String? signatureUrl;
  final List<String>? guias;
  final bool? personaJuridica;
  final NombreRepresentante nombreRepresentante;
  final String? dni;

  const PesosMedidasFormState(
      {this.guias,
      this.nombreRepresentante = const NombreRepresentante.pure(),
      this.cjto1 = const CJTO1.pure(),
      this.cjto2 = const CJTO2.pure(),
      this.cjto3 = const CJTO3.pure(),
      this.cjto4 = const CJTO4.pure(),
      this.cjto5 = const CJTO5.pure(),
      this.cjto6 = const CJTO6.pure(),
      this.fecha = const Fecha.pure(),
      this.registro = const Registro.pure(),
      this.nombreEmpresa = const NombreEmpresa.pure(),
      this.ruc = const Ruc.pure(),
      this.telefono = const Telefono.pure(),
      this.direccion = const Direccion.pure(),
      this.distrito = const Distrito.pure(),
      this.provincia = const Provincia.pure(),
      this.departamento = const Departamento.pure(),
      this.tipoMercancia = const TipoMercancia.pure(),
      this.tipoControl = const TipoControl.pure(),
      this.placas = const Placas.pure(),
      this.largo = const Largo.pure(),
      this.ancho = const Ancho.pure(),
      this.alto = const Alto.pure(),
      this.configuracionVehicular = const ConfiguracionVehicular.pure(),
      this.pesoBrutoMaximo = const PesoBrutoMaximo.pure(),
      this.pesoTransportado = const PesoTransportado.pure(),
      this.pbMaxNoControl = const PbMaxNoControl.pure(),
      this.pbMaxConBonificacion = const PbMaxConBonificacion.pure(),
      this.observaciones = const Observaciones.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.isValidate = false,
      this.message = '',
      this.signatureUrl,
      this.personaJuridica,
      this.dni});

  PesosMedidasFormState copyWith(
      {Fecha? fecha,
      Registro? registro,
      NombreEmpresa? nombreEmpresa,
      Ruc? ruc,
      Telefono? telefono,
      Direccion? direccion,
      Distrito? distrito,
      Provincia? provincia,
      Departamento? departamento,
      TipoMercancia? tipoMercancia,
      TipoControl? tipoControl,
      Placas? placas,
      Largo? largo,
      Ancho? ancho,
      Alto? alto,
      ConfiguracionVehicular? configuracionVehicular,
      PesoBrutoMaximo? pesoBrutoMaximo,
      PesoTransportado? pesoTransportado,
      PbMaxNoControl? pbMaxNoControl,
      PbMaxConBonificacion? pbMaxConBonificacion,
      Observaciones? observaciones,
      FormzSubmissionStatus? status,
      bool? isValidate,
      CJTO1? cjto1,
      CJTO2? cjto2,
      CJTO3? cjto3,
      CJTO4? cjto4,
      CJTO5? cjto5,
      CJTO6? cjto6,
      String? message,
      String? signatureUrl,
      List<String>? guias,
      bool? personaJuridica,
      NombreRepresentante? nombreRepresentante,
      String? dni}) {
    return PesosMedidasFormState(
        fecha: fecha ?? this.fecha,
        registro: registro ?? this.registro,
        nombreEmpresa: nombreEmpresa ?? this.nombreEmpresa,
        ruc: ruc ?? this.ruc,
        telefono: telefono ?? this.telefono,
        direccion: direccion ?? this.direccion,
        distrito: distrito ?? this.distrito,
        provincia: provincia ?? this.provincia,
        departamento: departamento ?? this.departamento,
        tipoMercancia: tipoMercancia ?? this.tipoMercancia,
        tipoControl: tipoControl ?? this.tipoControl,
        placas: placas ?? this.placas,
        largo: largo ?? this.largo,
        ancho: ancho ?? this.ancho,
        alto: alto ?? this.alto,
        configuracionVehicular: configuracionVehicular ?? this.configuracionVehicular,
        pesoBrutoMaximo: pesoBrutoMaximo ?? this.pesoBrutoMaximo,
        pesoTransportado: pesoTransportado ?? this.pesoTransportado,
        pbMaxNoControl: pbMaxNoControl ?? this.pbMaxNoControl,
        pbMaxConBonificacion: pbMaxConBonificacion ?? this.pbMaxConBonificacion,
        observaciones: observaciones ?? this.observaciones,
        status: status ?? this.status,
        isValidate: isValidate ?? this.isValidate,
        cjto1: cjto1 ?? this.cjto1,
        cjto2: cjto2 ?? this.cjto2,
        cjto3: cjto3 ?? this.cjto3,
        cjto4: cjto4 ?? this.cjto4,
        cjto5: cjto5 ?? this.cjto5,
        cjto6: cjto6 ?? this.cjto6,
        message: message ?? this.message,
        signatureUrl: signatureUrl ?? this.signatureUrl,
        guias: guias ?? this.guias,
        personaJuridica: personaJuridica ?? this.personaJuridica,
        nombreRepresentante: nombreRepresentante ?? this.nombreRepresentante,
        dni: dni ?? this.dni);
  }

  @override
  List<Object> get props => [
        fecha,
        registro,
        nombreEmpresa,
        ruc,
        telefono,
        direccion,
        distrito,
        provincia,
        departamento,
        tipoMercancia,
        tipoControl,
        placas,
        largo,
        ancho,
        alto,
        configuracionVehicular,
        pesoBrutoMaximo,
        pesoTransportado,
        pbMaxNoControl,
        pbMaxConBonificacion,
        observaciones,
        status,
        isValidate,
        cjto1,
        cjto2,
        cjto3,
        cjto4,
        cjto5,
        cjto6,
        message,
        signatureUrl ?? '',
        guias ?? '',
        personaJuridica ?? '',
        nombreRepresentante,
        dni ?? ''
      ];

  List<FormzInput> getInputs() {
    return [
      fecha,
      registro,
      // nombreEmpresa,
      // ruc,
      // telefono,
      direccion,
      distrito,
      provincia,
      departamento,
      // tipoMercancia,
      // tipoControl,
      // placas,
      // largo,
      // ancho,
      // alto,
      configuracionVehicular,
      // pesoBrutoMaximo,
      // pesoTransportado,
      nombreRepresentante
      // pbMaxNoControl,
      // pbMaxConBonificacion,
      // observaciones,
      // cjto1,
      // cjto2,
      // cjto3,
      // cjto4,
      // cjto5,
      // cjto6,
    ];
  }
}
