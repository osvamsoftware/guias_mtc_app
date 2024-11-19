import 'dart:convert';

class ApiGuiaTransportistaResponseModel {
  final bool? success;
  final Data? data;

  ApiGuiaTransportistaResponseModel({
    this.success,
    this.data,
  });

  ApiGuiaTransportistaResponseModel copyWith({
    bool? success,
    Data? data,
  }) =>
      ApiGuiaTransportistaResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory ApiGuiaTransportistaResponseModel.fromJson(String str) =>
      ApiGuiaTransportistaResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiGuiaTransportistaResponseModel.fromMap(Map<String, dynamic> json) => ApiGuiaTransportistaResponseModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "data": data?.toMap(),
      };
}

class Data {
  final String? number;
  final String? filename;
  final String? externalId;

  Data({
    this.number,
    this.filename,
    this.externalId,
  });

  Data copyWith({
    String? number,
    String? filename,
    String? externalId,
  }) =>
      Data(
        number: number ?? this.number,
        filename: filename ?? this.filename,
        externalId: externalId ?? this.externalId,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        number: json["number"],
        filename: json["filename"],
        externalId: json["external_id"],
      );

  Map<String, dynamic> toMap() => {
        "number": number,
        "filename": filename,
        "external_id": externalId,
      };
}
