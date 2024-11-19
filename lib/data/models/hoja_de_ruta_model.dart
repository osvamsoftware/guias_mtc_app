// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class HojaDeRutaModel {
  String? id;
  String? userId;
  String? folio;
  String? razonSocial;
  String? direccion;
  String? direccionOrigen;
  String? direccionDestino;
  String? correoElectronico;
  String? numeroPlaca;
  DateTime? fechaInicioViaje;
  DateTime? fechaLlegadaViaje;
  String? ruta;
  String? modalidadServicio;
  String? terminalSalida;
  String? terminalLlegada;
  String? escalasComerciales;
  DateTime? horaSalida;
  DateTime? horaLlegada;
  DateTime? createAt;

  List<Conductor>? conductores;
  final String? signatureUrl;
  final String? logoUrl;
  String? telefono;
  String? ruc;
  int? numPasajeros;
  String? distritoDestino;
  String? provinciaDestino;
  String? departamentoDestino;
  String? distritoOrigen;
  String? provinciaOrigen;
  String? departamentoOrigen;
  String? estado;
  String? revisionTecnica;
  String? soat;
  List<Itinerario> itinerarioList;
  final int? version;

  final String? nombreRepresentante;
  HojaDeRutaModel(
      {this.id,
      this.razonSocial,
      this.correoElectronico,
      this.numeroPlaca,
      this.fechaInicioViaje,
      this.fechaLlegadaViaje,
      this.createAt,
      this.ruta,
      this.modalidadServicio,
      this.terminalSalida,
      this.terminalLlegada,
      this.escalasComerciales,
      this.horaSalida,
      this.horaLlegada,
      this.conductores,
      this.userId,
      this.signatureUrl,
      this.logoUrl,
      this.telefono,
      this.ruc,
      this.numPasajeros,
      this.distritoDestino,
      this.provinciaDestino,
      this.departamentoDestino,
      this.distritoOrigen,
      this.provinciaOrigen,
      this.departamentoOrigen,
      this.estado,
      this.revisionTecnica,
      this.soat,
      this.itinerarioList = const [],
      this.direccionOrigen,
      this.direccionDestino,
      this.folio,
      this.version,
      this.nombreRepresentante,
      this.direccion});

  Map<String, dynamic> toJson({bool saveDateAsString = false}) {
    return {
      "id": id,
      "telefono": telefono,
      'razon_social': razonSocial,
      'correo_electronico': correoElectronico,
      'numero_placa': numeroPlaca,
      'fecha_inicio_viaje': saveDateAsString ? fechaInicioViaje?.toIso8601String() : fechaInicioViaje,
      'fecha_llegada_viaje': saveDateAsString ? fechaLlegadaViaje?.toIso8601String() : fechaLlegadaViaje,
      'ruta': ruta,
      'modalidad_servicio': modalidadServicio,
      'terminal_salida': terminalSalida,
      'terminal_llegada': terminalLlegada,
      'escalas_comerciales': escalasComerciales,
      'hora_salida': saveDateAsString ? horaSalida?.toIso8601String() : horaSalida,
      'hora_llegada': saveDateAsString ? horaLlegada?.toIso8601String() : horaLlegada,
      'conductores': conductores?.map((c) => c.toJson(saveDateAsString: true)).toList(),
      'user_id': userId,
      "signature_url": signatureUrl,
      "logo_url": logoUrl,
      "ruc": ruc,
      "num_pasajeros": numPasajeros,
      "distrito_destino": distritoDestino,
      "provincia_destino": provinciaDestino,
      "departamento_destino": departamentoDestino,
      "distrito_origen": distritoOrigen,
      "provincia_origen": provinciaOrigen,
      "departamento_origen": departamentoOrigen,
      "estado": estado,
      "revision_tecnica": revisionTecnica,
      "soat": soat,
      "itinerario_list": itinerarioList.map((itinerario) => itinerario.toJson()).toList(),
      "direccion_origen": direccionOrigen,
      "direccion_direccion": direccionDestino,
      "folio": folio,
      "version": version,
      "nombre_representante": nombreRepresentante,
      'created_at': saveDateAsString ? createAt?.toIso8601String() : createAt,
      "direccion": direccion
    };
  }

  factory HojaDeRutaModel.fromJson(Map<String, dynamic> json) {
    return HojaDeRutaModel(
        id: json['id'],
        telefono: json['telefono'],
        userId: json['user_id'],
        razonSocial: json['razon_social'],
        correoElectronico: json['correo_electronico'],
        numeroPlaca: json['numero_placa'],
        fechaInicioViaje: json['fecha_inicio_viaje'] is String
            ? DateTime.parse(json['fecha_inicio_viaje'])
            : (json['fecha_inicio_viaje'] as Timestamp?)?.toDate(),
        fechaLlegadaViaje: json['fecha_llegada_viaje'] is String
            ? DateTime.parse(json['fecha_llegada_viaje'])
            : (json['fecha_llegada_viaje'] as Timestamp?)?.toDate(),
        ruta: json['ruta'],
        modalidadServicio: json['modalidad_servicio'],
        terminalSalida: json['terminal_salida'],
        terminalLlegada: json['terminal_llegada'],
        escalasComerciales: json['escalas_comerciales'],
        horaSalida: json['hora_salida'] is String
            ? DateTime.parse(json['hora_salida'])
            : (json['hora_salida'] as Timestamp?)?.toDate(),
        horaLlegada: json['hora_llegada'] is String
            ? DateTime.parse(json['hora_llegada'])
            : (json['hora_llegada'] as Timestamp?)?.toDate(),
        conductores: json['conductores'] != null
            ? (json['conductores'] as List).map((c) => Conductor.fromJson(c)).toList()
            : null,
        signatureUrl: json["signature_url"],
        logoUrl: json['logo_url'],
        ruc: json['ruc'],
        numPasajeros: json['num_pasajeros'],
        distritoDestino: json['distrito_destino'],
        provinciaDestino: json['provincia_destino'],
        departamentoDestino: json['departamento_destino'],
        distritoOrigen: json['distrito_origen'],
        provinciaOrigen: json['provincia_origen'],
        departamentoOrigen: json['departamento_origen'],
        estado: json['estado'],
        revisionTecnica: json['revision_tecnica'],
        soat: json['soat'],
        itinerarioList: json['itinerario_list'] != null
            ? (json['itinerario_list'] as List).map((itinerario) => Itinerario.fromJson(itinerario)).toList()
            : [],
        direccionOrigen: json['direccion_origen'],
        direccionDestino: json['direccion_direccion'],
        folio: json['folio'],
        version: json['version'],
        nombreRepresentante: json['nombre_representante'],
        createAt: json['created_at'] is String
            ? DateTime.parse(json['created_at'])
            : (json['created_at'] as Timestamp?)?.toDate(),
        direccion: json['direccion']);
  }

  HojaDeRutaModel copyWith(
      {String? id,
      String? userId,
      String? razonSocial,
      String? direccion,
      String? correoElectronico,
      String? numeroPlaca,
      DateTime? fechaInicioViaje,
      DateTime? fechaLlegadaViaje,
      String? ruta,
      String? modalidadServicio,
      String? terminalSalida,
      String? terminalLlegada,
      String? escalasComerciales,
      DateTime? horaSalida,
      DateTime? horaLlegada,
      List<Conductor>? conductores,
      String? signatureUrl,
      String? logoUrl,
      String? telefono,
      String? ruc,
      int? numPasajeros,
      String? distritoDestino,
      String? provinciaDestino,
      String? departamentoDestino,
      String? distritoOrigen,
      String? provinciaOrigen,
      String? departamentoOrigen,
      String? estado,
      String? revisionTecnica,
      String? soat,
      List<Itinerario>? itinerarioList,
      String? direccionOrigen,
      String? direccionDestino,
      String? folio,
      int? version,
      String? nombreRepresentante,
      DateTime? createAt}) {
    return HojaDeRutaModel(
        id: id ?? this.id,
        logoUrl: logoUrl ?? this.logoUrl,
        userId: userId ?? this.userId,
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
        conductores: conductores ?? this.conductores,
        signatureUrl: signatureUrl ?? this.signatureUrl,
        telefono: telefono ?? this.telefono,
        ruc: ruc ?? this.ruc,
        numPasajeros: numPasajeros ?? this.numPasajeros,
        distritoDestino: distritoDestino ?? this.distritoDestino,
        provinciaDestino: provinciaDestino ?? this.provinciaDestino,
        departamentoDestino: departamentoDestino ?? this.departamentoDestino,
        distritoOrigen: distritoOrigen ?? this.distritoOrigen,
        provinciaOrigen: provinciaOrigen ?? this.provinciaOrigen,
        departamentoOrigen: departamentoOrigen ?? this.departamentoOrigen,
        estado: estado ?? this.estado,
        revisionTecnica: revisionTecnica ?? this.revisionTecnica,
        soat: soat ?? this.soat,
        itinerarioList: itinerarioList ?? this.itinerarioList,
        direccionOrigen: direccionOrigen ?? this.direccionOrigen,
        direccionDestino: direccionDestino ?? this.direccionDestino,
        folio: folio ?? this.folio,
        version: version ?? this.version,
        nombreRepresentante: nombreRepresentante ?? this.nombreRepresentante,
        createAt: createAt ?? this.createAt,
        direccion: direccion ?? this.direccion);
  }
}

class Conductor {
  String? nombre;
  String? licenciaConducir;
  DateTime? horaInicio;
  DateTime? horaTermino;
  String? turnoConduccion;
  Incidencia? incidencia;

  Conductor({
    this.nombre,
    this.licenciaConducir,
    this.horaInicio,
    this.horaTermino,
    this.turnoConduccion,
    this.incidencia,
  });

  Map<String, dynamic> toJson({bool saveDateAsString = false}) {
    return {
      'nombre': nombre,
      'licencia_conducir': licenciaConducir,
      'hora_inicio': saveDateAsString ? horaInicio?.toIso8601String() : horaInicio,
      'hora_termino': saveDateAsString ? horaTermino?.toIso8601String() : horaTermino,
      'turno_conduccion': turnoConduccion,
      'incidencia': incidencia?.toJson(saveDateAsString: true),
    };
  }

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return Conductor(
      nombre: json['nombre'],
      licenciaConducir: json['licencia_conducir'],
      horaInicio: (json['hora_inicio'] as Timestamp?)?.toDate(),
      horaTermino: (json['hora_termino'] as Timestamp?)?.toDate(),
      turnoConduccion: json['turno_conduccion'],
      incidencia: json['incidencia'] != null ? Incidencia.fromJson(json['incidencia']) : null,
    );
  }

  Conductor copyWith({
    String? nombre,
    String? licenciaConducir,
    DateTime? horaInicio,
    DateTime? horaTermino,
    String? turnoConduccion,
    Incidencia? incidencia,
  }) {
    return Conductor(
      nombre: nombre ?? this.nombre,
      licenciaConducir: licenciaConducir ?? this.licenciaConducir,
      horaInicio: horaInicio ?? this.horaInicio,
      horaTermino: horaTermino ?? this.horaTermino,
      turnoConduccion: turnoConduccion ?? this.turnoConduccion,
      incidencia: incidencia ?? this.incidencia,
    );
  }
}

class Incidencia {
  String? descripcion;
  String? lugar;
  DateTime? fechaHora;

  Incidencia({
    this.descripcion,
    this.lugar,
    this.fechaHora,
  });

  Map<String, dynamic> toJson({bool saveDateAsString = false}) {
    return {
      'descripcion': descripcion,
      'lugar': lugar,
      'fecha_hora': saveDateAsString ? fechaHora?.toIso8601String() : fechaHora,
    };
  }

  factory Incidencia.fromJson(Map<String, dynamic> json) {
    return Incidencia(
      descripcion: json['descripcion'],
      lugar: json['lugar'],
      fechaHora: (json['fecha_hora'] as Timestamp?)?.toDate(),
    );
  }

  Incidencia copyWith({
    String? descripcion,
    String? lugar,
    DateTime? fechaHora,
  }) {
    return Incidencia(
      descripcion: descripcion ?? this.descripcion,
      lugar: lugar ?? this.lugar,
      fechaHora: fechaHora ?? this.fechaHora,
    );
  }
}

class Itinerario {
  final String? distrito;
  final String? provincia;
  final String? departamento;

  Itinerario({
    this.distrito,
    this.provincia,
    this.departamento,
  });

  Map<String, dynamic> toJson() {
    return {
      'distrito': distrito,
      'provincia': provincia,
      'departamento': departamento,
    };
  }

  factory Itinerario.fromJson(Map<String, dynamic> json) {
    return Itinerario(
      distrito: json['distrito'],
      provincia: json['provincia'],
      departamento: json['departamento'],
    );
  }

  Itinerario copyWith({
    String? distrito,
    String? provincia,
    String? departamento,
  }) {
    return Itinerario(
      distrito: distrito ?? this.distrito,
      provincia: provincia ?? this.provincia,
      departamento: departamento ?? this.departamento,
    );
  }
}
