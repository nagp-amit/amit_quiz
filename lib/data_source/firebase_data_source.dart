import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:amit_quiz/model/app_user.dart';

class FirebaseDataSource {
  // Helper function to get the currently authenticated user
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  // Generates and returns a new firestore id
  String newId() {
    return firestore.collection('tmp').doc().id;
  }

  Future<AppUser?> getAppUser() async {
    final snapshot = await firestore.collection('users').doc(currentUser.uid).get();
    if (snapshot.exists) return AppUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<void> createAppUser(AppUser appUser) async {
    await firestore.collection('users').doc(appUser.id).set(appUser.toFirebaseMap());
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>> > getAll(collectionName) async {
    var result = await firestore.collection(collectionName).get();
    return result.docs;
  }
}
