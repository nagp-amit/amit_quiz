import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/repository/question_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuestionCubit extends Cubit<AppStates> {
  final QuestionRepositoryBase _questionRepository = getIt();

  QuestionCubit() : super(AppInitialState());

  Future<void> getQuestions(int categoryId) async {
    try {
      final questions = await _questionRepository.getQuestions(categoryId);
      emit(GetQuestionSuccessState(questions));
    } catch (e) {
      emit(GetQuestionErrorState("Error ${e.toString()}"));
    }
  }
}