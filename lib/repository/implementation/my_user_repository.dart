import 'dart:io';

import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/data_source/firebase_data_source.dart';
import 'package:amit_quiz/model/my_user.dart';
import 'package:amit_quiz/repository/my_user_repository.dart';

class MyUserRepositoryImp extends MyUserRepository {
  final FirebaseDataSource _fDataSource = getIt();

  @override
  String newId() {
    return _fDataSource.newId();
  }

  @override
  Future<MyUser?> getMyUser() => _fDataSource.getMyUser();

  @override
  Stream<Iterable<MyUser>> getMyUsers() {
    return _fDataSource.getMyUsers();
  }

  @override
  Future<void> saveMyUser(MyUser myUser, File? image) {
    return _fDataSource.saveMyUser(myUser, image);
  }

  @override
  Future<void> deleteMyUser(MyUser myUser) {
    return _fDataSource.deleteMyUser(myUser);
  }
}
