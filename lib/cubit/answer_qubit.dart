import 'package:amit_quiz/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnswerCubit extends Cubit<AnswerState> {

  AnswerCubit() : super(QuestionAnswerState(null, null, true));

  void saveQuizProgress(String questionId, int ans) {
    emit(SavingAnswer());
    emit(QuestionAnswerState(questionId, ans, null));
  }

  void resetProgress() {
    emit(QuestionAnswerState(null, null, true));
  }

  void submitQuiz() {
    emit(QuestionAnswerState(null, null, null));
  }
}