import 'package:amit_quiz/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuizCubit extends Cubit<QuizState> {

  QuizCubit() : super(QuizIndexState(currentIndex: 0));

  void updateQuizIndex(currentIndex) {
    emit(NextQuestionLoading());
    emit(QuizIndexState(currentIndex: currentIndex + 1));
  }

  void saveQuizProgress(String questionId, int ans){
    emit(QuizProgressState(questionId, ans));
  }

  void resetProgress() {
    emit(QuizProgressState.toClear());
    emit(QuizIndexState(currentIndex: 0));
  }

  void submitQuiz() {
    emit(QuizProgressState.toSubmit());
  }
}