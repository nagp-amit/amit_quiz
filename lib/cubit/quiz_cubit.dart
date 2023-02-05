import 'package:amit_quiz/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuizCubit extends Cubit<QuizIndexState> {

  QuizCubit() : super(QuizIndexState(currentIndex: 0));

  void updateQuizIndex() {
    emit(QuizIndexState(currentIndex: state.currentIndex + 1));
  }
}