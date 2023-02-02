import 'dart:async';

import 'package:amit_quiz/model/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryBase _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitialState());

  Future<void> reset() async => emit(AuthInitialState());

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

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignedOut extends AuthState {}

class AuthSigningIn extends AuthState {}

class AuthSignedIn extends AuthState {
  final AppUser user;

  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}
