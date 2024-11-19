// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, done, logoUpdated, error }

class SettingsState extends Equatable {
  final String? message;
  final SettingsStatus status;
  const SettingsState({this.message, required this.status});

  @override
  List<Object> get props => [message ?? '', status];

  SettingsState copyWith({
    String? message,
    SettingsStatus? status,
  }) {
    return SettingsState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
