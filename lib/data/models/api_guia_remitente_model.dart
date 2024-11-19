import 'dart:convert';

class ApiGuiaRemitenteResponseModel {
  final String? serieDocumento;
  final String? numeroDocumento;
  final DateTime? fechaDeEmision;
  final String? horaDeEmision;
  final String? codigoTipoDocumento;
  final DatosDelEmisor? datosDelEmisor;
  final DatosDelClienteOReceptor? datosDelClienteOReceptor;
  final String? observaciones;
  final String? codigoModoTransporte;
  final String? codigoMotivoTraslado;
  final String? descripcionMotivoTraslado;
  final DateTime? fechaDeTraslado;
  final String? codigoDePuerto;
  final bool? indicadorDeTransbordo;
  final String? unidadPesoTotal;
  final int? pesoTotal;
  final int? numeroDeBultos;
  final String? numeroDeContenedor;
  final Direccion? direccionPartida;
  final Direccion? direccionLlegada;
  final Chofer? chofer;
  final Vehiculo? vehiculo;
  final List<Item>? items;
  final List<DocumentoAfectado>? documentoAfectado;

  ApiGuiaRemitenteResponseModel({
    this.serieDocumento,
    this.numeroDocumento,
    this.fechaDeEmision,
    this.horaDeEmision,
    this.codigoTipoDocumento,
    this.datosDelEmisor,
    this.datosDelClienteOReceptor,
    this.observaciones,
    this.codigoModoTransporte,
    this.codigoMotivoTraslado,
    this.descripcionMotivoTraslado,
    this.fechaDeTraslado,
    this.codigoDePuerto,
    this.indicadorDeTransbordo,
    this.unidadPesoTotal,
    this.pesoTotal,
    this.numeroDeBultos,
    this.numeroDeContenedor,
    this.direccionPartida,
    this.direccionLlegada,
    this.chofer,
    this.vehiculo,
    this.items,
    this.documentoAfectado,
  });

  ApiGuiaRemitenteResponseModel copyWith(
          {String? serieDocumento,
          String? numeroDocumento,
          DateTime? fechaDeEmision,
          String? horaDeEmision,
          String? codigoTipoDocumento,
          DatosDelEmisor? datosDelEmisor,
          DatosDelClienteOReceptor? datosDelClienteOReceptor,
          String? observaciones,
          String? codigoModoTransporte,
          String? codigoMotivoTraslado,
          String? descripcionMotivoTraslado,
          DateTime? fechaDeTraslado,
          String? codigoDePuerto,
          bool? indicadorDeTransbordo,
          String? unidadPesoTotal,
          int? pesoTotal,
          int? numeroDeBultos,
          String? numeroDeContenedor,
          Direccion? direccionPartida,
          Direccion? direccionLlegada,
          Chofer? chofer,
          Vehiculo? vehiculo,
          List<Item>? items,
          List<DocumentoAfectado>? documentoAfectado}) =>
      ApiGuiaRemitenteResponseModel(
        serieDocumento: serieDocumento ?? this.serieDocumento,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        fechaDeEmision: fechaDeEmision ?? this.fechaDeEmision,
        horaDeEmision: horaDeEmision ?? this.horaDeEmision,
        codigoTipoDocumento: codigoTipoDocumento ?? this.codigoTipoDocumento,
        datosDelEmisor: datosDelEmisor ?? this.datosDelEmisor,
        datosDelClienteOReceptor: datosDelClienteOReceptor ?? this.datosDelClienteOReceptor,
        observaciones: observaciones ?? this.observaciones,
        codigoModoTransporte: codigoModoTransporte ?? this.codigoModoTransporte,
        codigoMotivoTraslado: codigoMotivoTraslado ?? this.codigoMotivoTraslado,
        descripcionMotivoTraslado: descripcionMotivoTraslado ?? this.descripcionMotivoTraslado,
        fechaDeTraslado: fechaDeTraslado ?? this.fechaDeTraslado,
        codigoDePuerto: codigoDePuerto ?? this.codigoDePuerto,
        indicadorDeTransbordo: indicadorDeTransbordo ?? this.indicadorDeTransbordo,
        unidadPesoTotal: unidadPesoTotal ?? this.unidadPesoTotal,
        pesoTotal: pesoTotal ?? this.pesoTotal,
        numeroDeBultos: numeroDeBultos ?? this.numeroDeBultos,
        numeroDeContenedor: numeroDeContenedor ?? this.numeroDeContenedor,
        direccionPartida: direccionPartida ?? this.direccionPartida,
        direccionLlegada: direccionLlegada ?? this.direccionLlegada,
        chofer: chofer ?? this.chofer,
        vehiculo: vehiculo ?? this.vehiculo,
        items: items ?? this.items,
        documentoAfectado: documentoAfectado ?? this.documentoAfectado,
      );

  factory ApiGuiaRemitenteResponseModel.fromJson(String str) => ApiGuiaRemitenteResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiGuiaRemitenteResponseModel.fromMap(Map<String, dynamic> json) => ApiGuiaRemitenteResponseModel(
        serieDocumento: json["serie_documento"],
        numeroDocumento: json["numero_documento"],
        fechaDeEmision: json["fecha_de_emision"] == null ? null : DateTime.parse(json["fecha_de_emision"]),
        horaDeEmision: json["hora_de_emision"],
        codigoTipoDocumento: json["codigo_tipo_documento"],
        datosDelEmisor: json["datos_del_emisor"] == null ? null : DatosDelEmisor.fromMap(json["datos_del_emisor"]),
        datosDelClienteOReceptor: json["datos_del_cliente_o_receptor"] == null
            ? null
            : DatosDelClienteOReceptor.fromMap(json["datos_del_cliente_o_receptor"]),
        observaciones: json["observaciones"],
        codigoModoTransporte: json["codigo_modo_transporte"],
        codigoMotivoTraslado: json["codigo_motivo_traslado"],
        descripcionMotivoTraslado: json["descripcion_motivo_traslado"],
        fechaDeTraslado: json["fecha_de_traslado"] == null ? null : DateTime.parse(json["fecha_de_traslado"]),
        codigoDePuerto: json["codigo_de_puerto"],
        indicadorDeTransbordo: json["indicador_de_transbordo"],
        unidadPesoTotal: json["unidad_peso_total"],
        pesoTotal: json["peso_total"],
        numeroDeBultos: json["numero_de_bultos"],
        numeroDeContenedor: json["numero_de_contenedor"],
        direccionPartida: json["direccion_partida"] == null ? null : Direccion.fromMap(json["direccion_partida"]),
        direccionLlegada: json["direccion_llegada"] == null ? null : Direccion.fromMap(json["direccion_llegada"]),
        chofer: json["chofer"] == null ? null : Chofer.fromMap(json["chofer"]),
        vehiculo: json["vehiculo"] == null ? null : Vehiculo.fromMap(json["vehiculo"]),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
        documentoAfectado: json["documento_afectado"] == null
            ? []
            : List<DocumentoAfectado>.from(json["documento_afectado"]!.map((x) => DocumentoAfectado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "serie_documento": serieDocumento,
        "numero_documento": numeroDocumento,
        "fecha_de_emision":
            "${fechaDeEmision!.year.toString().padLeft(4, '0')}-${fechaDeEmision!.month.toString().padLeft(2, '0')}-${fechaDeEmision!.day.toString().padLeft(2, '0')}",
        "hora_de_emision": horaDeEmision,
        "codigo_tipo_documento": codigoTipoDocumento,
        "datos_del_emisor": datosDelEmisor?.toMap(),
        "datos_del_cliente_o_receptor": datosDelClienteOReceptor?.toMap(),
        "observaciones": observaciones,
        "codigo_modo_transporte": codigoModoTransporte,
        "codigo_motivo_traslado": codigoMotivoTraslado,
        "descripcion_motivo_traslado": descripcionMotivoTraslado,
        "fecha_de_traslado":
            "${fechaDeTraslado!.year.toString().padLeft(4, '0')}-${fechaDeTraslado!.month.toString().padLeft(2, '0')}-${fechaDeTraslado!.day.toString().padLeft(2, '0')}",
        "codigo_de_puerto": codigoDePuerto,
        "indicador_de_transbordo": indicadorDeTransbordo,
        "unidad_peso_total": unidadPesoTotal,
        "peso_total": pesoTotal,
        "numero_de_bultos": numeroDeBultos,
        "numero_de_contenedor": numeroDeContenedor,
        "direccion_partida": direccionPartida?.toMap(),
        "direccion_llegada": direccionLlegada?.toMap(),
        "chofer": chofer?.toMap(),
        "vehiculo": vehiculo?.toMap(),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Chofer {
  final String? codigoTipoDocumentoIdentidad;
  final String? numeroDocumento;
  final String? nombres;
  final String? numeroLicencia;
  final String? telefono;

  Chofer({
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
}

class DatosDelClienteOReceptor {
  final String? codigoTipoDocumentoIdentidad;
  final String? numeroDocumento;
  final String? apellidosYNombresORazonSocial;
  final String? nombreComercial;
  final String? codigoPais;
  final String? ubigeo;
  final String? direccion;
  final String? correoElectronico;
  final String? telefono;

  DatosDelClienteOReceptor({
    this.codigoTipoDocumentoIdentidad,
    this.numeroDocumento,
    this.apellidosYNombresORazonSocial,
    this.nombreComercial,
    this.codigoPais,
    this.ubigeo,
    this.direccion,
    this.correoElectronico,
    this.telefono,
  });

  DatosDelClienteOReceptor copyWith({
    String? codigoTipoDocumentoIdentidad,
    String? numeroDocumento,
    String? apellidosYNombresORazonSocial,
    String? nombreComercial,
    String? codigoPais,
    String? ubigeo,
    String? direccion,
    String? correoElectronico,
    String? telefono,
  }) =>
      DatosDelClienteOReceptor(
        codigoTipoDocumentoIdentidad: codigoTipoDocumentoIdentidad ?? this.codigoTipoDocumentoIdentidad,
        numeroDocumento: numeroDocumento ?? this.numeroDocumento,
        apellidosYNombresORazonSocial: apellidosYNombresORazonSocial ?? this.apellidosYNombresORazonSocial,
        nombreComercial: nombreComercial ?? this.nombreComercial,
        codigoPais: codigoPais ?? this.codigoPais,
        ubigeo: ubigeo ?? this.ubigeo,
        direccion: direccion ?? this.direccion,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        telefono: telefono ?? this.telefono,
      );

  factory DatosDelClienteOReceptor.fromJson(String str) => DatosDelClienteOReceptor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosDelClienteOReceptor.fromMap(Map<String, dynamic> json) => DatosDelClienteOReceptor(
        codigoTipoDocumentoIdentidad: json["codigo_tipo_documento_identidad"],
        numeroDocumento: json["numero_documento"],
        apellidosYNombresORazonSocial: json["apellidos_y_nombres_o_razon_social"],
        nombreComercial: json["nombre_comercial"],
        codigoPais: json["codigo_pais"],
        ubigeo: json["ubigeo"],
        direccion: json["direccion"],
        correoElectronico: json["correo_electronico"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toMap() => {
        "codigo_tipo_documento_identidad": codigoTipoDocumentoIdentidad,
        "numero_documento": numeroDocumento,
        "apellidos_y_nombres_o_razon_social": apellidosYNombresORazonSocial,
        "nombre_comercial": nombreComercial,
        "codigo_pais": codigoPais,
        "ubigeo": ubigeo,
        "direccion": direccion,
        "correo_electronico": correoElectronico,
        "telefono": telefono,
      };
}

class DatosDelEmisor {
  final String? codigoPais;
  final String? ubigeo;
  final String? direccion;
  final String? correoElectronico;
  final String? telefono;
  final String? codigoDelDomicilioFiscal;

  DatosDelEmisor({
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
}

class Direccion {
  final String? ubigeo;
  final String? direccion;
  final String? codigoDelDomicilioFiscal;

  Direccion({
    this.ubigeo,
    this.direccion,
    this.codigoDelDomicilioFiscal,
  });

  Direccion copyWith({
    String? ubigeo,
    String? direccion,
    String? codigoDelDomicilioFiscal,
  }) =>
      Direccion(
        ubigeo: ubigeo ?? this.ubigeo,
        direccion: direccion ?? this.direccion,
        codigoDelDomicilioFiscal: codigoDelDomicilioFiscal ?? this.codigoDelDomicilioFiscal,
      );

  factory Direccion.fromJson(String str) => Direccion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Direccion.fromMap(Map<String, dynamic> json) => Direccion(
        ubigeo: json["ubigeo"],
        direccion: json["direccion"],
        codigoDelDomicilioFiscal: json["codigo_del_domicilio_fiscal"],
      );

  Map<String, dynamic> toMap() => {
        "ubigeo": ubigeo,
        "direccion": direccion,
        "codigo_del_domicilio_fiscal": codigoDelDomicilioFiscal,
      };
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

class Item {
  final String? codigoInterno;
  final int? cantidad;

  Item({
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
}

class Vehiculo {
  final String? numeroDePlaca;
  final String? modelo;
  final String? marca;

  Vehiculo({
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
}
