import 'dart:async';

import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/model/app_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/repository/auth_repository.dart';

class AuthCubit extends Cubit<AppStates> {
  final AuthRepositoryBase _authRepository;

  AuthCubit(this._authRepository) : super(AppInitialState());

  Future<void> reset() async => emit(AppInitialState());

  Future<void> signUp(String name, String email, String password) =>
      _signIn(_authRepository.signUp(name, email, password));

  Future<void> login(String email, String password) =>
      _signIn(_authRepository.login(email, password));

  Future<void> _signIn(Future<AppUser?> auxUser) async {
    try {
      emit(AuthSigningIn());
      final user = await auxUser;
      if (user == null) {
        emit(AuthError("Unknown error, try again later"));
      } else {
        emit(AuthSignedIn(user));
      }
    } catch (e) {
      emit(AuthError("Error ${e.toString()}"));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthSignedOut());
  }
}