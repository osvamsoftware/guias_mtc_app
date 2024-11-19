import 'package:app_remision/domain/repository/media_storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final MediaStorageRepository _mediaStorageRepository;
  SettingsCubit(this._mediaStorageRepository) : super(const SettingsState(status: SettingsStatus.initial));

  Future<void> uploadLogo(String userId, String filePath) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      String logoUrl = await _mediaStorageRepository.uploadLogo(filePath);
      await _mediaStorageRepository.saveLogoUrl(userId, logoUrl);
      emit(state.copyWith(status: SettingsStatus.logoUpdated));
    } catch (e) {
      emit(state.copyWith(status: SettingsStatus.error, message: e.toString()));
    }
  }
}
