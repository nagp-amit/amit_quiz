import 'dart:io';

import 'package:amit_quiz/constants/app_constants.dart';
import 'package:amit_quiz/data_source/firebase_data_source.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/model/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amit_quiz/repository/auth_repository.dart';

class AuthRepository extends AuthRepositoryBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDataSource _fDataSource = getIt();

  @override
  Future<AppUser?> signUp(String name, String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (authResult.user != null) {
      var uid = authResult.user!.uid;
      AppUser req = AppUser(
        id: uid,
        name: name,
        email: email,
        image: defaultImageUrl
      );
      await _fDataSource.createAppUser(req);
      var appUser = await getCurrentUser();
      return appUser;
    } else {
      return null;
    }
  }

  @override
  Future<AppUser?> login(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (authResult.user != null) {
      final appUser = await _fDataSource.getAppUser();
      return appUser;
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future updateUser({required String name,required File? image}) async {
    final user = FirebaseAuth.instance.currentUser;
    var updateReq = {
      'name': name
    };
    if (image != null) {
      final fileName = image.uri.pathSegments.last;
      final imagePath = 'UsersImages/{user?.uid-}$fileName';
      final storageRef = _fDataSource.storage.ref(imagePath);
      await storageRef.putFile(image);
      final url = await storageRef.getDownloadURL();
      updateReq["image"] = url;
    }

    await _fDataSource.firestore.collection('users').doc(user?.uid).update(updateReq);
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final appUser = await _fDataSource.getAppUser();
    return appUser;
  }
}
