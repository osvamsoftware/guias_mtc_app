// Definición de excepciones personalizadas

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseExceptionR implements FirebaseException {
  final String _code;
  final String? _message;
  final String _plugin;
  final StackTrace? _stackTrace;

  FirebaseExceptionR(this._code, this._message, this._plugin, [this._stackTrace]);

  @override
  String get code => _code;
  @override
  String? get message => _message;
  @override
  String get plugin => _plugin;
  @override
  StackTrace? get stackTrace => _stackTrace;
}

class AuthException implements Exception {
  final String message;
  final int code;
  AuthException(this.message, {this.code = 401});
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() {
    return 'APIException: $message';
  }
}
