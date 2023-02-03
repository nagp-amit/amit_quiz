import 'package:amit_quiz/model/category_model.dart';

abstract class CategoryRepositoryBase {

  Future<List<CategoryModel>> getCategories();
}
