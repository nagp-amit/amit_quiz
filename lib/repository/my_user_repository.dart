import 'dart:io';

import 'package:amit_quiz/model/my_user.dart';

abstract class MyUserRepository {
  String newId();

  Future<MyUser?> getMyUser();

  Stream<Iterable<MyUser>> getMyUsers();

  Future<void> saveMyUser(MyUser myUser, File? image);

  Future<void> deleteMyUser(MyUser myUser);
}
