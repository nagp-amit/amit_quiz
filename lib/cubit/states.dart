import 'package:amit_quiz/model/app_user.dart';
import 'package:amit_quiz/model/category_model.dart';
import 'package:amit_quiz/model/question_model.dart';
import 'package:amit_quiz/model/result_model.dart';
import 'package:equatable/equatable.dart';

abstract class AppStates extends Equatable {
   @override
  List<Object?> get props => [];
}


// Auth State

class AppInitialState extends AppStates {}

class AuthError extends AppStates {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignedOut extends AppStates {}

class AuthSigningIn extends AppStates {}

class AuthSignedIn extends AppStates {
  final AppUser user;

  AuthSignedIn(this.user);

  @override
  List<Object?> get props => [user];
}


// Category State
class GetCategorySuccessState extends AppStates {
  final List<CategoryModel> categories;

  GetCategorySuccessState(this.categories);

  @override
  List<Object?> get props => [categories];
}

class GetCategoryErrorState extends AppStates {
  final String error;

  GetCategoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// Question State
class GetQuestionSuccessState extends AppStates {
  final List<QuestionModel> questions;

  GetQuestionSuccessState(this.questions);

  @override
  List<Object?> get props => [questions];
}

class GetQuestionErrorState extends AppStates {
  final String error;

  GetQuestionErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

// Quiz State

abstract class QuizState extends Equatable {
   @override
  List<Object?> get props => [];
}

class NextQuestionLoading extends QuizState {}


class QuizIndexState extends QuizState {
  final int currentIndex;
  QuizIndexState({
    required this.currentIndex
  });
}

abstract class AnswerState extends Equatable {
   @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class QuestionAnswerState extends AnswerState {
  Map<String, int> answeredQuestions = {};
  QuestionAnswerState(Map<String, int> data) {
    answeredQuestions = Map.from(data);
  }
}

class SavingAnswer extends AnswerState {}


class GetHistorySuccessState extends AppStates {
  final List<ResultModel> results;

  GetHistorySuccessState(this.results);

  @override
  List<Object?> get props => [results];
}

class GetHistoryErrorState extends AppStates {
  final String error;

  GetHistoryErrorState(this.error);

  @override
  List<Object?> get props => [error];
}