import 'dart:convert';

class TicketResponseModel {
  final bool? success;
  final Data? data;
  final Links? links;
  final String? message;

  TicketResponseModel({
    this.success,
    this.data,
    this.links,
    this.message,
  });

  TicketResponseModel copyWith({
    bool? success,
    Data? data,
    Links? links,
    String? message,
  }) =>
      TicketResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
        links: links ?? this.links,
        message: message ?? this.message,
      );

  factory TicketResponseModel.fromJson(String str) => TicketResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketResponseModel.fromMap(Map<String, dynamic> json) => TicketResponseModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        links: json["links"] == null ? null : Links.fromMap(json["links"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data?.toMap(),
        "links": links?.toMap(),
        "message": message,
      };
}

class Data {
  final String? number;
  final String? filename;
  final String? externalId;
  final String? stateTypeId;
  final String? qrUrl;
  final String? qrImage;

  Data({
    this.number,
    this.filename,
    this.externalId,
    this.stateTypeId,
    this.qrUrl,
    this.qrImage,
  });

  Data copyWith({
    String? number,
    String? filename,
    String? externalId,
    String? stateTypeId,
    String? qrUrl,
    String? qrImage,
  }) =>
      Data(
        number: number ?? this.number,
        filename: filename ?? this.filename,
        externalId: externalId ?? this.externalId,
        stateTypeId: stateTypeId ?? this.stateTypeId,
        qrUrl: qrUrl ?? this.qrUrl,
        qrImage: qrImage ?? this.qrImage,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        number: json["number"],
        filename: json["filename"],
        externalId: json["external_id"],
        stateTypeId: json["state_type_id"],
        qrUrl: json["qr_url"],
        qrImage: json["qr_image"],
      );

  Map<String, dynamic> toMap() => {
        "number": number,
        "filename": filename,
        "external_id": externalId,
        "state_type_id": stateTypeId,
        "qr_url": qrUrl,
        "qr_image": qrImage,
      };
}

class Links {
  final String? xmlUnsigned;
  final String? xml;
  final String? pdf;
  final String? cdr;

  Links({
    this.xmlUnsigned,
    this.xml,
    this.pdf,
    this.cdr,
  });

  Links copyWith({
    String? xmlUnsigned,
    String? xml,
    String? pdf,
    String? cdr,
  }) =>
      Links(
        xmlUnsigned: xmlUnsigned ?? this.xmlUnsigned,
        xml: xml ?? this.xml,
        pdf: pdf ?? this.pdf,
        cdr: cdr ?? this.cdr,
      );

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        xmlUnsigned: json["xml_unsigned"],
        xml: json["xml"],
        pdf: json["pdf"],
        cdr: json["cdr"],
      );

  Map<String, dynamic> toMap() => {
        "xml_unsigned": xmlUnsigned,
        "xml": xml,
        "pdf": pdf,
        "cdr": cdr,
      };
}
