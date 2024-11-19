part of 'guia_transportista_cubit.dart';

enum GuiaTransportistaStatus {
  initial,
  loading,
  done,
  error;
}

class GuiaTransportistaState {
  final ApiGuiaTransportistaModel guiaTransportistaModel;
  final TicketResponseModel? ticketResponse;
  final GuiaTransportistaStatus guiaTransportistaStatus;
  final String? message;

  //--- locaL form variable
  final String tipoDocumento;
  final String tipoDocumentoConductorTemp;
  final String unidadPesoItem;

  const GuiaTransportistaState(
      {required this.tipoDocumentoConductorTemp,
      required this.tipoDocumento,
      required this.guiaTransportistaModel,
      required this.guiaTransportistaStatus,
      this.message,
      this.ticketResponse,
      required this.unidadPesoItem});

  // @override
  // List<Object> get props => [ticketResponse ?? '', guiaTransportistaModel, guiaTransportistaStatus, message ?? ''];

  GuiaTransportistaState copyWith(
      {ApiGuiaTransportistaModel? guiaTransportistaModel,
      TicketResponseModel? ticketResponse,
      GuiaTransportistaStatus? guiaTransportistaStatus,
      String? message,
      String? tipoDocumento,
      String? unidadPesoItem,
      String? tipoDocumentoConductorTemp}) {
    return GuiaTransportistaState(
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      guiaTransportistaModel: guiaTransportistaModel ?? this.guiaTransportistaModel,
      ticketResponse: ticketResponse ?? this.ticketResponse,
      guiaTransportistaStatus: guiaTransportistaStatus ?? this.guiaTransportistaStatus,
      message: message ?? this.message,
      tipoDocumentoConductorTemp: tipoDocumentoConductorTemp ?? this.tipoDocumentoConductorTemp,
      unidadPesoItem: unidadPesoItem ?? this.unidadPesoItem,
    );
  }
}
