import 'package:cloud_firestore/cloud_firestore.dart';

class VerificacionPesosMedidasModel {
  final String? id;
  final String? userId;
  final DateTime? fecha;
  final String? registro;
  final String? nombreEmpresa;
  final String? ruc;
  final String? telefono;
  final String? direccion;
  final String? distrito;
  final String? provincia;
  final String? departamento;
  final String? tipoMercancia;
  final String? tipoControl;
  final double? largo;
  final double? ancho;
  final double? alto;
  final String? configuracionVehicular;
  final double? pesoBrutoMaximo;
  final double? pesoTransportado;
  final double? pbMaxNoControl;
  final double? pbMaxConBonificacion;
  final List<double>? pesosPorEjes;
  final String? observaciones;
  final String? signatureUrl;
  final double? cjto1;
  final double? cjto2;
  final double? cjto3;
  final double? cjto4;
  final double? cjto5;
  final double? cjto6;
  final List<String>? guias;
  final int? version;
  final bool? personaJuridica;
  final String? nombreRepresentante;
  final String? dni;
  final String? placas1;
  final String? placas2;
  final String? placas3;

  final String? logoUrl;
  VerificacionPesosMedidasModel(
      {this.id,
      this.nombreRepresentante,
      this.userId,
      this.fecha,
      this.registro,
      this.nombreEmpresa,
      this.ruc,
      this.telefono,
      this.direccion,
      this.distrito,
      this.provincia,
      this.departamento,
      this.tipoMercancia,
      this.tipoControl,
      this.largo,
      this.ancho,
      this.alto,
      this.configuracionVehicular,
      this.pesoBrutoMaximo,
      this.pesoTransportado,
      this.pbMaxNoControl,
      this.pbMaxConBonificacion,
      this.pesosPorEjes,
      this.observaciones,
      this.signatureUrl,
      this.cjto1,
      this.cjto2,
      this.cjto3,
      this.cjto4,
      this.cjto5,
      this.cjto6,
      this.logoUrl,
      this.guias,
      this.version,
      this.personaJuridica,
      this.dni,
      this.placas1,
      this.placas2,
      this.placas3});

  VerificacionPesosMedidasModel copyWith(
      {String? id,
      String? userId,
      DateTime? fecha,
      String? registro,
      String? nombreEmpresa,
      String? ruc,
      String? telefono,
      String? direccion,
      String? distrito,
      String? provincia,
      String? departamento,
      String? tipoMercancia,
      String? tipoControl,
      String? placas,
      double? largo,
      double? ancho,
      double? alto,
      String? configuracionVehicular,
      double? pesoBrutoMaximo,
      double? pesoTransportado,
      double? pbMaxNoControl,
      double? pbMaxConBonificacion,
      List<double>? pesosPorEjes,
      String? observaciones,
      String? signatureUrl,
      double? cjto1,
      double? cjto2,
      double? cjto3,
      double? cjto4,
      double? cjto5,
      double? cjto6,
      String? logoUrl,
      List<String>? guias,
      int? version,
      bool? personaJuridica,
      String? nombreRepresentante,
      String? dni,
      String? placas1,
      String? placas2,
      String? placas3}) {
    return VerificacionPesosMedidasModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
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
        largo: largo ?? this.largo,
        ancho: ancho ?? this.ancho,
        alto: alto ?? this.alto,
        configuracionVehicular: configuracionVehicular ?? this.configuracionVehicular,
        pesoBrutoMaximo: pesoBrutoMaximo ?? this.pesoBrutoMaximo,
        pesoTransportado: pesoTransportado ?? this.pesoTransportado,
        pbMaxNoControl: pbMaxNoControl ?? this.pbMaxNoControl,
        pbMaxConBonificacion: pbMaxConBonificacion ?? this.pbMaxConBonificacion,
        pesosPorEjes: pesosPorEjes ?? this.pesosPorEjes,
        observaciones: observaciones ?? this.observaciones,
        signatureUrl: signatureUrl ?? this.signatureUrl,
        cjto1: cjto1 ?? this.cjto1,
        cjto2: cjto2 ?? this.cjto2,
        cjto3: cjto3 ?? this.cjto3,
        cjto4: cjto4 ?? this.cjto4,
        cjto5: cjto5 ?? this.cjto5,
        cjto6: cjto6 ?? this.cjto6,
        logoUrl: logoUrl ?? this.logoUrl,
        guias: guias ?? this.guias,
        version: version ?? this.version,
        personaJuridica: personaJuridica ?? this.personaJuridica,
        nombreRepresentante: nombreRepresentante ?? this.nombreRepresentante,
        dni: dni ?? this.dni,
        placas1: placas1 ?? this.placas1,
        placas2: placas2 ?? this.placas2,
        placas3: placas3 ?? this.placas3);
  }

  Map<String, dynamic> toJson({bool saveDateAsString = false}) {
    return {
      'id': id,
      'user_id': userId,
      'fecha': saveDateAsString ? fecha?.toIso8601String() : fecha,
      'registro': registro,
      'nombre_empresa': nombreEmpresa,
      'ruc': ruc,
      'telefono': telefono,
      'direccion': direccion,
      'distrito': distrito,
      'provincia': provincia,
      'departamento': departamento,
      'tipo_mercancia': tipoMercancia,
      'tipo_control': tipoControl,
      'largo': largo,
      'ancho': ancho,
      'alto': alto,
      'configuracion_vehicular': configuracionVehicular,
      'peso_bruto_maximo': pesoBrutoMaximo,
      'peso_transportado': pesoTransportado,
      'pb_max_no_control': pbMaxNoControl,
      'pb_max_con_bonificacion': pbMaxConBonificacion,
      'pesos_por_ejes': pesosPorEjes,
      'observaciones': observaciones,
      'signature_url': signatureUrl,
      'cjto1': cjto1,
      'cjto2': cjto2,
      'cjto3': cjto3,
      'cjto4': cjto4,
      'cjto5': cjto5,
      'cjto6': cjto6,
      'logo_url': logoUrl,
      'guias': guias,
      'version': version,
      'persona_juridica': personaJuridica,
      'nombre_representante': nombreRepresentante,
      'dni': dni,
      "placas_1": placas1,
      "placas_2": placas2,
      "placas_3": placas3
    };
  }

  factory VerificacionPesosMedidasModel.fromJson(Map<String, dynamic> json, String id) {
    return VerificacionPesosMedidasModel(
        id: id,
        userId: json['user_id'],
        fecha: json['fecha'] is String ? DateTime.parse(json['fecha']) : (json['fecha'] as Timestamp?)?.toDate(),
        registro: json['registro'],
        nombreEmpresa: json['nombre_empresa'],
        ruc: json['ruc'],
        telefono: json['telefono'],
        direccion: json['direccion'],
        distrito: json['distrito'],
        provincia: json['provincia'],
        departamento: json['departamento'],
        tipoMercancia: json['tipo_mercancia'],
        tipoControl: json['tipo_control'],
        largo: json['largo'],
        ancho: json['ancho'],
        alto: json['alto'],
        configuracionVehicular: json['configuracion_vehicular'],
        pesoBrutoMaximo: json['peso_bruto_maximo'],
        pesoTransportado: json['peso_transportado'],
        pbMaxNoControl: json['pb_max_no_control'],
        pbMaxConBonificacion: json['pb_max_con_bonificacion'],
        pesosPorEjes: List<double>.from(json['pesos_por_ejes'] ?? []),
        observaciones: json['observaciones'],
        signatureUrl: json['signature_url'],
        cjto1: json['cjto1'],
        cjto2: json['cjto2'],
        cjto3: json['cjto3'],
        cjto4: json['cjto4'],
        cjto5: json['cjto5'],
        cjto6: json['cjto6'],
        logoUrl: json['logo_url'],
        guias: List<String>.from(json['guias'] ?? []),
        version: json['version'],
        personaJuridica: json['persona_juridica'] ?? false,
        nombreRepresentante: json['nombre_representante'],
        dni: json['dni'],
        placas1: json['placas_1'],
        placas2: json['placas_2'],
        placas3: json['placas_3']);
  }
}
