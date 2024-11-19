import 'package:cloud_firestore/cloud_firestore.dart';

class ManifiestoModel {
  final String? id;
  final String? folio;
  final int? version;
  final String? userId;
  final String? razonSocial;
  final String? direccion;
  final String? telefono;
  final String? correoElectronico;
  final DateTime? fechaViaje;

  final String? placaVehicular;
  final String? ruta;
  final String? modalidadServicio;
  final String? signatureUrl;
  final String? logoUrl;
  final List<Pasajero>? pasajeros;

  ManifiestoModel(
      {this.folio,
      this.version,
      this.id,
      this.userId,
      this.razonSocial,
      this.direccion,
      this.telefono,
      this.correoElectronico,
      this.fechaViaje,
      this.placaVehicular,
      this.ruta,
      this.modalidadServicio,
      this.pasajeros,
      this.signatureUrl,
      this.logoUrl});

  Map<String, dynamic> toJson({bool saveDateAsString = false}) {
    return {
      'id': id,
      'user_id': userId,
      'razon_social': razonSocial,
      'direccion': direccion,
      'telefono': telefono,
      'correo_electronico': correoElectronico,
      'fecha_viaje': saveDateAsString ? fechaViaje?.toIso8601String() : fechaViaje,
      'placa_vehicular': placaVehicular,
      'ruta': ruta,
      'modalidad_servicio': modalidadServicio,
      'signature_url': signatureUrl,
      'logo_url': logoUrl,
      'pasajeros': pasajeros?.map((p) => p.toJson()).toList(),
      'folio': folio,
      'version': version,
    };
  }

  factory ManifiestoModel.fromJson(Map<String, dynamic> json) {
    return ManifiestoModel(
        id: json['id'],
        userId: json['user_id'],
        razonSocial: json['razon_social'],
        direccion: json['direccion'],
        telefono: json['telefono'],
        correoElectronico: json['correo_electronico'],
        fechaViaje: json['fecha_viaje'] is String
            ? DateTime.parse(json['fecha_viaje'])
            : (json['fecha_viaje'] as Timestamp?)?.toDate(),
        placaVehicular: json['placa_vehicular'],
        ruta: json['ruta'],
        modalidadServicio: json['modalidad_servicio'],
        signatureUrl: json['signature_url'],
        pasajeros: (json['pasajeros'] as List).map((p) => Pasajero.fromJson(p)).toList(),
        logoUrl: json['logo_url'],
        folio: json['folio'],
        version: json['version']);
  }
  ManifiestoModel copyWith({
    String? id,
    String? userId,
    String? razonSocial,
    String? direccion,
    String? telefono,
    String? correoElectronico,
    DateTime? fechaViaje,
    String? placaVehicular,
    String? ruta,
    String? modalidadServicio,
    String? signatureUrl,
    String? logoUrl,
    List<Pasajero>? pasajeros,
    String? folio,
    int? version,
  }) {
    return ManifiestoModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        razonSocial: razonSocial ?? this.razonSocial,
        direccion: direccion ?? this.direccion,
        telefono: telefono ?? this.telefono,
        correoElectronico: correoElectronico ?? this.correoElectronico,
        fechaViaje: fechaViaje ?? this.fechaViaje,
        placaVehicular: placaVehicular ?? this.placaVehicular,
        ruta: ruta ?? this.ruta,
        modalidadServicio: modalidadServicio ?? this.modalidadServicio,
        signatureUrl: signatureUrl ?? this.signatureUrl,
        pasajeros: pasajeros ?? this.pasajeros,
        logoUrl: logoUrl ?? this.logoUrl,
        folio: folio ?? this.folio,
        version: version ?? this.version);
  }
}

class Pasajero {
  final String? id;
  final String? apellidosNombres;
  final String? documentoIdentidad;
  final int? edad;

  Pasajero({
    this.id,
    this.apellidosNombres,
    this.documentoIdentidad,
    this.edad,
  });

  Map<String, dynamic> toJson() {
    return {
      'apellidos_nombres': apellidosNombres,
      'documento_identidad': documentoIdentidad,
      'edad': edad,
    };
  }

  factory Pasajero.fromJson(Map<String, dynamic> json) {
    return Pasajero(
      id: json['id'],
      apellidosNombres: json['apellidos_nombres'],
      documentoIdentidad: json['documento_identidad'],
      edad: json['edad'],
    );
  }

  Pasajero copyWith({
    String? id,
    String? apellidosNombres,
    String? documentoIdentidad,
    int? edad,
  }) {
    return Pasajero(
      id: id ?? this.id,
      apellidosNombres: apellidosNombres ?? this.apellidosNombres,
      documentoIdentidad: documentoIdentidad ?? this.documentoIdentidad,
      edad: edad ?? this.edad,
    );
  }
}
