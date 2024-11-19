import 'package:app_remision/core/constants/api_endpoints.dart';
import 'package:app_remision/core/settings/api_services.dart';
import 'package:app_remision/core/settings/exception_handler.dart';
import 'package:app_remision/data/models/api_guia_remitente_model.dart';
import 'package:app_remision/data/models/enviar_sunat_response_model.dart';
import 'package:app_remision/data/models/ticket_response_model.dart';

abstract class GuiaRemitenteRepository {
  Future<ApiGuiaRemitenteResponseModel?> createGuiaRemitente(ApiGuiaRemitenteResponseModel guiaRemitente);
  Future<EnviarSunatResponseModel> enviarExternalIdSunat(String externalId);
  Future<TicketResponseModel> obtenerTicketSunat(String externalId);
}

class SunatGuiaRemitenteRepository extends GuiaRemitenteRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<ApiGuiaRemitenteResponseModel> createGuiaRemitente(ApiGuiaRemitenteResponseModel guiaRemitente) async {
    try {
      final ApiGuiaRemitenteResponseModel guiaResponse =
          await _apiService.post(apiEndpoints.baseUrl, body: guiaRemitente.toJson());
      return guiaResponse;
    } on ApiException catch (_) {
      rethrow;
    }
  }

  @override
  Future<EnviarSunatResponseModel> enviarExternalIdSunat(String externalId) async {
    try {
      final EnviarSunatResponseModel sunatResponse =
          await _apiService.post(apiEndpoints.sendExternalIdSunatUrl, body: {"external_id": externalId});
      return sunatResponse;
    } on ApiException catch (_) {
      rethrow;
    }
  }

  @override
  Future<TicketResponseModel> obtenerTicketSunat(String externalId) async {
    try {
      final TicketResponseModel ticketResponseModel =
          await _apiService.post(apiEndpoints.getTicketSunatUrl, body: {"external_id": externalId});
      return ticketResponseModel;
    } on ApiException catch (_) {
      rethrow;
    }
  }

  //! ------- guardar en local el ticket sunat (firebase)
}
