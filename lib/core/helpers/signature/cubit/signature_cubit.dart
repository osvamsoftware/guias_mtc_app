import 'package:app_remision/core/settings/exception_handler.dart';
import 'package:app_remision/domain/repository/signature_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signature_state.dart';

class SignatureCubit extends Cubit<SignatureCState> {
  final SignatureRepository _signatureRepository;

  SignatureCubit(this._signatureRepository) : super(const SignatureCState(status: SignatureStatus.init));

  Future<void> uploadSignature(String filePath) async {
    emit(state.copyWith(status: SignatureStatus.uploading));
    try {
      String downloadUrl = await _signatureRepository.uploadSignature(filePath);
      emit(state.copyWith(status: SignatureStatus.success, urlImage: downloadUrl));
    } catch (e) {
      String errorMessage;
      if (e is FirebaseExceptionR) {
        errorMessage = 'Firebase Error: ${e.message}';
      } else {
        errorMessage = 'Error uploading signature: $e';
      }
      emit(state.copyWith(status: SignatureStatus.error, message: errorMessage));
    }
  }

  Future<void> saveSignature(String userId, String filePath) async {
    emit(state.copyWith(status: SignatureStatus.loading));
    try {
      String signatureUrl = await _signatureRepository.uploadSignature(filePath);
      await _signatureRepository.saveSignatureUrl(userId, signatureUrl);

      emit(state.copyWith(status: SignatureStatus.success, urlImage: signatureUrl));
    } catch (e) {
      emit(state.copyWith(status: SignatureStatus.error, message: e.toString()));
    }
  }
}
