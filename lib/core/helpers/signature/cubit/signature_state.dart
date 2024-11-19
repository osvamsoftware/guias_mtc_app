// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signature_cubit.dart';

enum SignatureStatus { init, loading, uploading, success, error }

class SignatureCState extends Equatable {
  final SignatureStatus status;
  final String? urlImage;
  final String? message;
  const SignatureCState({this.message, required this.status, this.urlImage});

  @override
  List<Object> get props => [status, urlImage ?? '', message ?? ''];

  SignatureCState copyWith({
    SignatureStatus? status,
    String? urlImage,
    String? message,
  }) {
    return SignatureCState(
        status: status ?? this.status, urlImage: urlImage ?? this.urlImage, message: message ?? this.message);
  }
}
