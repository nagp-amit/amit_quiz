import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoryCubit extends Cubit<AppStates> {
  final CategoryRepositoryBase _categoryRepository = getIt();

  CategoryCubit() : super(AppInitialState());

  Future<void> getCategories() async {
    try {
      final categories = await _categoryRepository.getCategories();
      emit(GetCategorySuccessState(categories));
    } catch (e) {
      emit(GetCategoryErrorState("Error ${e.toString()}"));
    }
  }
}