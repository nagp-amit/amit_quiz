import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/repository/result_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoryCubit extends Cubit<AppStates> {
  final ResultRepositoryBase _resultRepository = getIt();

  HistoryCubit() : super(AppInitialState());

  Future<void> getResults() async {
    try {
      final results = await _resultRepository.getResults();
      emit(GetHistorySuccessState(results));
    } catch (e) {
      emit(GetHistoryErrorState("Error ${e.toString()}"));
    }
  }
}