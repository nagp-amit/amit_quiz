import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/result_repository.dart';


class AnswerCubit extends Cubit<AnswerState> {

  final ResultRepositoryBase _resultRepository = getIt();
  AnswerCubit() : super(QuestionAnswerState(null, null));

  Future<void> saveQuizProgress(String questionId, int ans) async {
    await  _resultRepository.saveResult({'questionIdl': questionId, 'ans': ans, 'DT': DateTime.now()});
    emit(SavingAnswer());
    emit(QuestionAnswerState(questionId, ans));
  }

  void resetProgress() {
    emit(QuestionAnswerState(null, null));
  }

  Future<void> saveResult(Map<String, dynamic> result) async {
    await  _resultRepository.saveResult(result);
  }
}