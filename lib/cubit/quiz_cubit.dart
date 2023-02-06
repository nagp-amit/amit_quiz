import 'package:amit_quiz/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizIndexState(currentIndex: 0));

  void updateQuizIndex(currentIndex) {
    emit(NextQuestionLoading());
    emit(QuizIndexState(currentIndex: currentIndex + 1));
  }

  void resetIndexState() {
    emit(QuizIndexState(currentIndex: 0));
  }
}