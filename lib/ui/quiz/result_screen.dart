import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/question_cubit.dart';
import 'package:amit_quiz/cubit/quiz_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/widgets/content_area.dart';
import 'package:amit_quiz/widgets/default_button.dart';
import 'package:amit_quiz/widgets/quiz_app_bar.dart';
import 'package:amit_quiz/widgets/screen_background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const ResultScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (_, state) {
          if (state is QuizProgressState) {
            return BackgroundDecoration(
              child:
                  ResultDescription(answeredQuestions: state.answeredQuestions),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ResultDescription extends StatelessWidget {
  final Map<String, int> answeredQuestions;
  const ResultDescription({super.key, required this.answeredQuestions});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetQuestionSuccessState) {
            var resultDetails = getResultDetails(state);
            if (resultDetails['error'] != null) {
              const snackBar = SnackBar(content: Text("Invalid Login"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              return Column(
                children: [
                  QuizAppBar(
                    leading: const SizedBox(
                      height: kToolbarHeight,
                    ),
                    title:
                        "${resultDetails['correctCount']} out of ${resultDetails['total']} are correct",
                  ),
                  Expanded(
                    child: ContentArea(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/bulb.svg'),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            'Congratulations',
                            style: TextStyle(color: mainColor.shade800),
                          ),
                        ),
                        Text(
                          'You have got ${resultDetails['score']!.toString()} Points',
                          style: TextStyle(color: mainColor.shade800),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                      width: 75,
                                      height: 70,
                                      color: mainColor.shade700,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Total',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              resultDetails['total']!
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                      width: 75,
                                      height: 70,
                                      color: const Color.fromARGB(
                                          255, 11, 163, 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Correct',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              resultDetails['correctCount']!
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                      width: 75,
                                      height: 70,
                                      color: const Color.fromARGB(
                                          255, 253, 51, 36),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Wrong',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              resultDetails['wrongCount']!
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                      width: 95,
                                      height: 70,
                                      color: const Color.fromARGB(
                                          255, 162, 130, 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('UnAnswered',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              resultDetails['unAnsweredCount']!
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                  ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: DefaultButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (Route<dynamic> route) => false);
                              },
                              title: 'Go to home',
                            ))
                          ],
                        )),
                  )
                ],
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Map<String, dynamic> getResultDetails(GetQuestionSuccessState state) {
    int total = state.questions.length;
    int correctCount = 0;
    int wrongCount = 0;
    int unAnsweredCount = 0;
    String categoryId = '';
    String error = '';
    try {
      for (var q in state.questions) {
        categoryId = q.categoryId;
        var userAnswer = answeredQuestions[q.id];
        if (userAnswer != null) {
          if (q.correctAnsId == userAnswer) {
            correctCount++;
          } else {
            wrongCount++;
          }
        } else {
          unAnsweredCount++;
        }
      }
    } catch (e) {
      error = e.toString();
    }
    int score = int.parse(
        ((correctCount + wrongCount) - (wrongCount * .25)).toString());
    return {
      'total': total,
      'correctCount': correctCount,
      'wrongCount': wrongCount,
      'unAnsweredCount': unAnsweredCount,
      'score': score,
      'categoryId': int.parse(categoryId),
      'error': error
    };
  }
}
