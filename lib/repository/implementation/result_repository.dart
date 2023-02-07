import 'package:amit_quiz/data_source/firebase_data_source.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/model/result_model.dart';
import 'package:amit_quiz/repository/result_repository.dart';

class ResultRepository extends ResultRepositoryBase {
  final FirebaseDataSource _fDataSource = getIt();
  final String collectionName = "results";

  @override
  Future<void> saveResult(ResultModel result) async {
    result.userId = _fDataSource.currentUser.uid;
    result.createdOn = DateTime.now();
    var data = result.toFirebaseMap();
    await _fDataSource.firestore.collection(collectionName).add(data);
  }

  @override
  Future<List<ResultModel>> getResults() async {
    var result = await _fDataSource.firestore.collection(collectionName).where("userId", isEqualTo: _fDataSource.currentUser.uid).get();

    List<ResultModel> results = [];
    for (var element in result.docs) {
        results.add(ResultModel.fromFirebaseMap(element.data()));
    }
    return results;
  }
}
