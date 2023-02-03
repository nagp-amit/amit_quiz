import 'package:amit_quiz/model/app_user.dart';
import 'package:amit_quiz/model/category_model.dart';
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


//Get Category
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