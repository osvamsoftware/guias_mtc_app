class ApiEndpoints {
  final String baseUrl;

//!--- DECLARE
  static const String _createGuiaRemisionTransportista = '';
  static const String _sendExternalIdSunat = '/send';
  static const String _getTicketSunat = '/status_ticket';

  ApiEndpoints({required this.baseUrl});

//!--- GETS
  String get createGuiaTransportistaUrl => _constructUrl(_createGuiaRemisionTransportista);
  String get sendExternalIdSunatUrl => _constructUrl(_sendExternalIdSunat);
  String get getTicketSunatUrl => _constructUrl(_getTicketSunat);

  String _constructUrl(String path) => '$baseUrl$path';
}

final apiEndpoints = ApiEndpoints(
  //
  // baseUrl: 'https://api.planeanutricion.com/api/'
  baseUrl: 'https://planeta.brialesoft.com/api/dispatches',
);
