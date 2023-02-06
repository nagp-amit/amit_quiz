import 'package:amit_quiz/data_source/firebase_data_source.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/repository/result_repository.dart';

class ResultRepository extends ResultRepositoryBase {
  final FirebaseDataSource _fDataSource = getIt();
  final String collectionName = "results";

  @override
  Future<void> saveResult(Map<String, dynamic> result) async {
    result['userId'] = _fDataSource.currentUser.uid;
    await _fDataSource.firestore.collection(collectionName).add(result);
  }
}
