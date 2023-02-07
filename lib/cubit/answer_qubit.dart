import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/model/result_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/result_repository.dart';


class AnswerCubit extends Cubit<AnswerState> {

  final ResultRepositoryBase _resultRepository = getIt();
  AnswerCubit() : super(QuestionAnswerState(const {}));

  Future<void> saveQuizProgress(Map<String, int> data) async {
    emit(SavingAnswer());
    emit(QuestionAnswerState(data));
  }

  void resetProgress() {
    emit(QuestionAnswerState(const {}));
  }

  Future<void> saveResult(ResultModel result) async {
    await  _resultRepository.saveResult(result);
  }
}