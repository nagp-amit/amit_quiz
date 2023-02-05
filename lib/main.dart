import 'package:amit_quiz/cubit/category_cubit.dart';
import 'package:amit_quiz/cubit/question_cubit.dart';
import 'package:amit_quiz/cubit/quiz_cubit.dart';
import 'package:amit_quiz/repository/auth_repository.dart';
import 'package:amit_quiz/repository/category_repository.dart';
import 'package:amit_quiz/repository/implementation/category_repository.dart';
import 'package:amit_quiz/repository/implementation/question_repository.dart';
import 'package:amit_quiz/repository/question_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/app.dart';
import 'package:amit_quiz/cubit/auth_cubit.dart';
import 'package:amit_quiz/repository/implementation/auth_repository.dart';
import 'package:get_it/get_it.dart';

import 'data_source/firebase_data_source.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => AuthCubit(AuthRepository())),
      BlocProvider(create: (BuildContext context) => CategoryCubit()..getCategories()),
      BlocProvider(create: (BuildContext context) => QuestionCubit()),
      BlocProvider(create: (BuildContext context) => QuizCubit()),
    ], child: MyApp.create())
  );
}

// Helper function to inject dependencies
Future<void> injectDependencies() async {
  // Inject the data sources.
  getIt.registerLazySingleton(() => FirebaseDataSource());

  // Inject the Repositories. Note that the type is the abstract class
  // and the injected instance is the implementation.
  getIt.registerLazySingleton<AuthRepositoryBase>(() => AuthRepository());
  getIt.registerLazySingleton<CategoryRepositoryBase>(() => CategoryRepository());
  getIt.registerLazySingleton<QuestionRepositoryBase>(() => QuestionRepository());
}