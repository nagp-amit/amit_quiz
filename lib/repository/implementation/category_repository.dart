import 'package:amit_quiz/data_source/firebase_data_source.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/model/category_model.dart';
import 'package:amit_quiz/repository/category_repository.dart';

class CategoryRepository extends CategoryRepositoryBase {
  final FirebaseDataSource _fDataSource = getIt();
  final String collectionName = "categories";

  @override
  Future<List<CategoryModel>> getCategories() async {
    var result = await _fDataSource.firestore.collection(collectionName).get();

    List<CategoryModel> categories = [];
    for (var element in result.docs) {
        categories.add(CategoryModel.fromFirebaseMap(int.parse(element.id), element.data()));
    }
    return categories;
  }
}
