import 'package:app_remision/data/models/user_model.dart';
import 'package:app_remision/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      await authRepository.signIn(email, password);
      emit(const AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Future<void> signUp(String email, String password) async {
  //   try {
  //     emit(AuthLoading());
  //     await authRepository.signUp(email, password);
  //     emit(AuthAuthenticated());
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //   }
  // }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthentication() async {
    try {
      emit(AuthLoading());
      final userModel = await authRepository.isAuthenticated();
      if (userModel != null) {
        emit(AuthAuthenticated(userModel: userModel));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
