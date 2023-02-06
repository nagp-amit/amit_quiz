import 'package:amit_quiz/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuizCubit extends Cubit<QuizState> {

  QuizCubit() : super(QuizIndexState(currentIndex: 0));

  void updateQuizIndex(currentIndex) {
    emit(NextQuestionLoading());
    emit(QuizIndexState(currentIndex: currentIndex + 1));
  }

  void saveQuizProgress(String questionId, int ans){
    emit(QuizProgressState(questionId, ans, null));
  }

  void resetProgress() {
    emit(QuizProgressState(null, null, true));
  }

  void resetIndexState() {
    emit(QuizIndexState(currentIndex: 0));
  }

  void submitQuiz() {
    emit(QuizProgressState(null, null, null));
  }

  void saveResult(Map<String, int> result) {

  }
}