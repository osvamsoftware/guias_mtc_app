part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final UserModel? userModel;
  const AuthState({this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({super.userModel});
  @override
  List<Object?> get props => [userModel];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
