import 'package:amit_quiz/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnswerCubit extends Cubit<AnswerState> {

  AnswerCubit() : super(QuestionAnswerState.reset());

  void saveQuizProgress(String questionId, int ans) {
    emit(SavingAnswer());
    emit(QuestionAnswerState(questionId, ans));
  }

  void resetProgress() {
    emit(QuestionAnswerState.reset());
  }
}