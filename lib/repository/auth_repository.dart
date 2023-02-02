import 'package:amit_quiz/model/app_user.dart';

abstract class AuthRepositoryBase {

  Future<AppUser?> signUp(String name, String email, String password);

  Future<AppUser?> login(String email, String password);

  Future<void> signOut();
}
