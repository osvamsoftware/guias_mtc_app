import 'dart:convert';

import 'package:app_remision/data/models/api_guia_remitente_model.dart';
import 'package:equatable/equatable.dart';

class ApiGuiaTransportistaModel extends Equatable {
  final String? serieDocumento;
  final String? numeroDocumento;
  final DateTime? fechaDeEmision;
  final String? horaDeEmision;
  final String? codigoTipoDocumento;
  final DatosDelEmisor? datosDelEmisor;

  final String? observaciones;
  final DateTime? fechaDeTraslado;
  final String? unidadPesoTotal;
  final int? pesoTotal;
  final Usuario? remitente;
  final Direccion? direccionPartidaRemitente;
  final Usuario? destinatario;
  final Direccion? direccionLlegadaDestinatario;
  final List<Chofer>? chofer;
  final List<Vehiculo>? vehiculo;
  final List<Item>? items;
  //! --- TODO POSIBLE CAMBIO DE NOMBRE
  final List<DocumentoAfectado>? documentoAfectado;
  final bool? vehiculoVacio;
  final bool? envasesVacios;
  final bool? transbordoProgramado;
  final bool? transladoTotalDeBienes;
  final bool? transporteSubcontratado;
  final String? contratoVehicular;

  const ApiGuiaTransportistaModel(
      {this.documentoAfectado,
      this.vehiculoVacio,
      this.envasesVacios,
      this.transbordoProgramado,
      this.transladoTotalDeBienes,
      this.transporteSubcontratado,
      this.serieDocumento,
      this.numeroDocumento,
      this.fechaDeEmision,
      this.horaDeEmision,
      this.codigoTipoDocumento,
      this.datosDelEmisor,
      this.observaciones,
      this.fechaDeTraslado,
      this.unidadPesoTotal,
      this.pesoTotal,
      this.remitente,
      this.direccionPartidaRemitente,
      this.destinatario,
      this.direccionLlegadaDestinatario,
      this.chofer,
      this.vehiculo,
      this.items,
      this.contratoVehicular});

  ApiGuiaTransportistaModel copyWith({
    String? serieDocumento,
    String? numeroDocumento,
    DateTime? fechaDeEmision,
    String? horaDeEmision,
    String? codigoTipoDocumento,
    DatosDelEmisor? datosDelEmisor,
    String? observaciones,
    DateTime? fechaDeTraslado,
    String? unidadPesoTotal,
    int? pesoTotal,
    Usuario? remitente,
    Direccion? direccionPartidaRemitente,
    Usuario? destinatario,
    Direccion? direccionLlegadaDestinatario,
    List<Chofer>? chofer,
    List<Vehiculo>? vehiculo,
    List<Item>? items,
    bool? vehiculoVacio,
    bool? envasesVacios,
    bool? transbordoProgramado,
    bool? transladoTotalDeBienes,
    bool? transporteSubcontratado,
    String? contratoVehicular,
    List<DocumentoAfectado>? documentoAfectado,
  }) =>
      ApiGuiaTransportistaModel(
        serieDocumento: serieDocumento ?? this.serieDocumento,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        fechaDeEmision: fechaDeEmision ?? this.fechaDeEmision,
        horaDeEmision: horaDeEmision ?? this.horaDeEmision,
        codigoTipoDocumento: codigoTipoDocumento ?? this.codigoTipoDocumento,
        datosDelEmisor: datosDelEmisor ?? this.datosDelEmisor,
        observaciones: observaciones ?? this.observaciones,
        fechaDeTraslado: fechaDeTraslado ?? this.fechaDeTraslado,
        unidadPesoTotal: unidadPesoTotal ?? this.unidadPesoTotal,
        pesoTotal: pesoTotal ?? this.pesoTotal,
        remitente: remitente ?? this.remitente,
        direccionPartidaRemitente: direccionPartidaRemitente ?? this.direccionPartidaRemitente,
        destinatario: destinatario ?? this.destinatario,
        direccionLlegadaDestinatario: direccionLlegadaDestinatario ?? this.direccionLlegadaDestinatario,
        chofer: chofer ?? this.chofer,
        vehiculo: vehiculo ?? this.vehiculo,
        items: items ?? this.items,
        vehiculoVacio: vehiculoVacio ?? this.vehiculoVacio,
        envasesVacios: envasesVacios ?? this.envasesVacios,
        transbordoProgramado: transbordoProgramado ?? this.transbordoProgramado,
        transladoTotalDeBienes: transladoTotalDeBienes ?? this.transladoTotalDeBienes,
        transporteSubcontratado: transporteSubcontratado ?? this.transporteSubcontratado,
        contratoVehicular: contratoVehicular ?? this.contratoVehicular,
        documentoAfectado: documentoAfectado ?? this.documentoAfectado,
      );

  factory ApiGuiaTransportistaModel.fromJson(String str) => ApiGuiaTransportistaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiGuiaTransportistaModel.fromMap(Map<String, dynamic> json) => ApiGuiaTransportistaModel(
      serieDocumento: json["serie_documento"],
      numeroDocumento: json["numero_documento"],
      fechaDeEmision: json["fecha_de_emision"] == null ? null : DateTime.parse(json["fecha_de_emision"]),
      horaDeEmision: json["hora_de_emision"],
      codigoTipoDocumento: json["codigo_tipo_documento"],
      datosDelEmisor: json["datos_del_emisor"] == null ? null : DatosDelEmisor.fromMap(json["datos_del_emisor"]),
      observaciones: json["observaciones"],
      fechaDeTraslado: json["fecha_de_traslado"] == null ? null : DateTime.parse(json["fecha_de_traslado"]),
      unidadPesoTotal: json["unidad_peso_total"],
      pesoTotal: json["peso_total"],
      remitente: json["remitente"] == null ? null : Usuario.fromMap(json["remitente"]),
      direccionPartidaRemitente:
          json["direccion_partida_remitente"] == null ? null : Direccion.fromMap(json["direccion_partida_remitente"]),
      destinatario: json["destinatario"] == null ? null : Usuario.fromMap(json["destinatario"]),
      direccionLlegadaDestinatario: json["direccion_llegada_destinatario"] == null
          ? null
          : Direccion.fromMap(json["direccion_llegada_destinatario"]),
      chofer: json["chofer"] == null ? [] : List<Chofer>.from(json["chofer"]!.map((x) => Chofer.fromMap(x))),
      vehiculo: json["vehiculo"] == null ? [] : List<Vehiculo>.from(json["vehiculo"]!.map((x) => Vehiculo.fromMap(x))),
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
      vehiculoVacio: json["vehiculo_vacio"],
      envasesVacios: json["envases_vacios"],
      transbordoProgramado: json["transbordo_programado"],
      transladoTotalDeBienes: json["traslado_total_de_bienes"],
      transporteSubcontratado: json["transporte_subcontratado"],
      contratoVehicular: json["contrato_vehicular"],
      documentoAfectado: json["documento_afectado"] == null
          ? []
          : List<DocumentoAfectado>.from(json["documento_afectado"]!.map((x) => DocumentoAfectado.fromMap(x))));

  Map<String, dynamic> toMap() => {
        "serie_documento": serieDocumento,
        "numero_documento": numeroDocumento,
        "fecha_de_emision":
            "${fechaDeEmision!.year.toString().padLeft(4, '0')}-${fechaDeEmision!.month.toString().padLeft(2, '0')}-${fechaDeEmision!.day.toString().padLeft(2, '0')}",
        "hora_de_emision": horaDeEmision,
        "codigo_tipo_documento": codigoTipoDocumento,
        "datos_del_emisor": datosDelEmisor?.toMap(),
        "observaciones": observaciones,
        "fecha_de_traslado":
            "${fechaDeTraslado!.year.toString().padLeft(4, '0')}-${fechaDeTraslado!.month.toString().padLeft(2, '0')}-${fechaDeTraslado!.day.toString().padLeft(2, '0')}",
        "unidad_peso_total": unidadPesoTotal,
        "peso_total": pesoTotal,
        "remitente": remitente?.toMap(),
        "direccion_partida_remitente": direccionPartidaRemitente?.toMap(),
        "destinatario": destinatario?.toMap(),
        "direccion_llegada_destinatario": direccionLlegadaDestinatario?.toMap(),
        "chofer": chofer == null ? [] : List<dynamic>.from(chofer!.map((x) => x.toMap())),
        "vehiculo": vehiculo == null ? [] : List<dynamic>.from(vehiculo!.map((x) => x.toMap())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
        "vehiculo_vacio": vehiculoVacio,
        "envases_vacios": envasesVacios,
        "transbordo_programado": transbordoProgramado,
        "traslado_total_de_bienes": transladoTotalDeBienes,
        "transporte_subcontratado": transporteSubcontratado,
        "contrato_vehicular": contratoVehicular,
        "documento_afectado":
            documentoAfectado == null ? [] : List<dynamic>.from(documentoAfectado!.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [
        serieDocumento,
        numeroDocumento,
        fechaDeEmision,
        horaDeEmision,
        codigoTipoDocumento,
        datosDelEmisor,
        observaciones,
        fechaDeTraslado,
        unidadPesoTotal,
        pesoTotal,
        remitente,
        direccionPartidaRemitente,
        destinatario,
        direccionLlegadaDestinatario,
        chofer,
        vehiculo,
        items,
        vehiculoVacio,
        envasesVacios,
        transbordoProgramado,
        transladoTotalDeBienes,
        transporteSubcontratado,
        contratoVehicular,
        documentoAfectado
      ];
}

class Chofer extends Equatable {
  final String? codigoTipoDocumentoIdentidad;
  final String? numeroDocumento;
  final String? nombres;
  final String? numeroLicencia;
  final String? telefono;

  const Chofer({
    this.codigoTipoDocumentoIdentidad,
    this.numeroDocumento,
    this.nombres,
    this.numeroLicencia,
    this.telefono,
  });

  Chofer copyWith({
    String? codigoTipoDocumentoIdentidad,
    String? numeroDocumento,
    String? nombres,
    String? numeroLicencia,
    String? telefono,
  }) =>
      Chofer(
        codigoTipoDocumentoIdentidad: codigoTipoDocumentoIdentidad ?? this.codigoTipoDocumentoIdentidad,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        nombres: nombres ?? this.nombres,
        numeroLicencia: numeroLicencia ?? this.numeroLicencia,
        telefono: telefono ?? this.telefono,
      );

  factory Chofer.fromJson(String str) => Chofer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chofer.fromMap(Map<String, dynamic> json) => Chofer(
        codigoTipoDocumentoIdentidad: json["codigo_tipo_documento_identidad"],
        numeroDocumento: json["numero_documento"],
        nombres: json["nombres"],
        numeroLicencia: json["numero_licencia"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toMap() => {
        "codigo_tipo_documento_identidad": codigoTipoDocumentoIdentidad,
        "numero_documento": numeroDocumento,
        "nombres": nombres,
        "numero_licencia": numeroLicencia,
        "telefono": telefono,
      };

  @override
  List<Object?> get props => [
        codigoTipoDocumentoIdentidad,
        numeroDocumento,
        nombres,
        numeroLicencia,
        telefono,
      ];
}

class DatosDelEmisor extends Equatable {
  final String? codigoPais;
  final String? ubigeo;
  final String? direccion;
  final String? correoElectronico;
  final String? telefono;
  final String? codigoDelDomicilioFiscal;

  const DatosDelEmisor({
    this.codigoPais,
    this.ubigeo,
    this.direccion,
    this.correoElectronico,
    this.telefono,
    this.codigoDelDomicilioFiscal,
  });

  DatosDelEmisor copyWith({
    String? codigoPais,
    String? ubigeo,
    String? direccion,
    String? correoElectronico,
    String? telefono,
    String? codigoDelDomicilioFiscal,
  }) =>
      DatosDelEmisor(
        codigoPais: codigoPais ?? this.codigoPais,
        ubigeo: ubigeo ?? this.ubigeo,
        direccion: direccion ?? this.direccion,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        telefono: telefono ?? this.telefono,
        codigoDelDomicilioFiscal: codigoDelDomicilioFiscal ?? this.codigoDelDomicilioFiscal,
      );

  factory DatosDelEmisor.fromJson(String str) => DatosDelEmisor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosDelEmisor.fromMap(Map<String, dynamic> json) => DatosDelEmisor(
        codigoPais: json["codigo_pais"],
        ubigeo: json["ubigeo"],
        direccion: json["direccion"],
        correoElectronico: json["correo_electronico"],
        telefono: json["telefono"],
        codigoDelDomicilioFiscal: json["codigo_del_domicilio_fiscal"],
      );

  Map<String, dynamic> toMap() => {
        "codigo_pais": codigoPais,
        "ubigeo": ubigeo,
        "direccion": direccion,
        "correo_electronico": correoElectronico,
        "telefono": telefono,
        "codigo_del_domicilio_fiscal": codigoDelDomicilioFiscal,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        codigoPais,
        ubigeo,
        direccion,
        correoElectronico,
        telefono,
        codigoDelDomicilioFiscal,
      ];
}

class Usuario extends Equatable {
  final String? codigoTipoDocumentoIdentidad;
  final String? numeroDocumento;
  final String? apellidosYNombresORazonSocial;

  const Usuario({
    this.codigoTipoDocumentoIdentidad,
    this.numeroDocumento,
    this.apellidosYNombresORazonSocial,
  });

  Usuario copyWith({
    String? codigoTipoDocumentoIdentidad,
    String? numeroDocumento,
    String? apellidosYNombresORazonSocial,
  }) =>
      Usuario(
        codigoTipoDocumentoIdentidad: codigoTipoDocumentoIdentidad ?? this.codigoTipoDocumentoIdentidad,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        apellidosYNombresORazonSocial: apellidosYNombresORazonSocial ?? this.apellidosYNombresORazonSocial,
      );

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        codigoTipoDocumentoIdentidad: json["codigo_tipo_documento_identidad"],
        numeroDocumento: json["numero_documento"],
        apellidosYNombresORazonSocial: json["apellidos_y_nombres_o_razon_social"],
      );

  Map<String, dynamic> toMap() => {
        "codigo_tipo_documento_identidad": codigoTipoDocumentoIdentidad,
        "numero_documento": numeroDocumento,
        "apellidos_y_nombres_o_razon_social": apellidosYNombresORazonSocial,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        codigoTipoDocumentoIdentidad,
        numeroDocumento,
        apellidosYNombresORazonSocial,
      ];
}

class Direccion extends Equatable {
  final String? ubigeo;
  final String? direccion;

  const Direccion({
    this.ubigeo,
    this.direccion,
  });

  Direccion copyWith({
    String? ubigeo,
    String? direccion,
  }) =>
      Direccion(
        ubigeo: ubigeo ?? this.ubigeo,
        direccion: direccion ?? this.direccion,
      );

  factory Direccion.fromJson(String str) => Direccion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Direccion.fromMap(Map<String, dynamic> json) => Direccion(
        ubigeo: json["ubigeo"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toMap() => {
        "ubigeo": ubigeo,
        "direccion": direccion,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [ubigeo, direccion];
}

class Item extends Equatable {
  final String? codigoInterno;
  final int? cantidad;

  const Item({
    this.codigoInterno,
    this.cantidad,
  });

  Item copyWith({
    String? codigoInterno,
    int? cantidad,
  }) =>
      Item(
        codigoInterno: codigoInterno ?? this.codigoInterno,
        cantidad: cantidad ?? this.cantidad,
      );

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        codigoInterno: json["codigo_interno"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toMap() => {
        "codigo_interno": codigoInterno,
        "cantidad": cantidad,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        codigoInterno,
        cantidad,
      ];
}

class Vehiculo extends Equatable {
  final String? numeroDePlaca;
  final String? modelo;
  final String? marca;

  const Vehiculo({
    this.numeroDePlaca,
    this.modelo,
    this.marca,
  });

  Vehiculo copyWith({
    String? numeroDePlaca,
    String? modelo,
    String? marca,
  }) =>
      Vehiculo(
        numeroDePlaca: numeroDePlaca ?? this.numeroDePlaca,
        modelo: modelo ?? this.modelo,
        marca: marca ?? this.marca,
      );

  factory Vehiculo.fromJson(String str) => Vehiculo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vehiculo.fromMap(Map<String, dynamic> json) => Vehiculo(
        numeroDePlaca: json["numero_de_placa"],
        modelo: json["modelo"],
        marca: json["marca"],
      );

  Map<String, dynamic> toMap() => {
        "numero_de_placa": numeroDePlaca,
        "modelo": modelo,
        "marca": marca,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        numeroDePlaca,
        modelo,
        marca,
      ];
}

class DocumentoAfectado {
  final String? serieDocumento;
  final String? numeroDocumento;
  final String? codigoTipoDocumento;

  DocumentoAfectado({
    this.serieDocumento,
    this.numeroDocumento,
    this.codigoTipoDocumento,
  });

  DocumentoAfectado copyWith({
    String? serieDocumento,
    String? numeroDocumento,
    String? codigoTipoDocumento,
  }) =>
      DocumentoAfectado(
        serieDocumento: serieDocumento ?? this.serieDocumento,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        codigoTipoDocumento: codigoTipoDocumento ?? this.codigoTipoDocumento,
      );

  factory DocumentoAfectado.fromJson(String str) => DocumentoAfectado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocumentoAfectado.fromMap(Map<String, dynamic> json) => DocumentoAfectado(
        serieDocumento: json["serie_documento"],
        numeroDocumento: json["numero_documento"],
        codigoTipoDocumento: json["codigo_tipo_documento"],
      );

  Map<String, dynamic> toMap() => {
        "serie_documento": serieDocumento,
        "numero_documento": numeroDocumento,
        "codigo_tipo_documento": codigoTipoDocumento,
      };
}
