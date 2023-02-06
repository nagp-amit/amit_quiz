import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/result_repository.dart';


class QuizCubit extends Cubit<QuizState> {
  final ResultRepositoryBase _resultRepository = getIt();
  QuizCubit() : super(QuizIndexState(currentIndex: 0));

  void updateQuizIndex(currentIndex) {
    emit(NextQuestionLoading());
    emit(QuizIndexState(currentIndex: currentIndex + 1));
  }

  void resetIndexState() {
    emit(QuizIndexState(currentIndex: 0));
  }

  Future<void> saveResult(Map<String, int> result) async {
    await  _resultRepository.saveResult(result);
  }
}