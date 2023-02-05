import 'package:amit_quiz/config/colors.dart';
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
              child: Column(
                children: [
                  const QuizAppBar(
                    leading: SizedBox(
                      height: kToolbarHeight,
                    ),
                    title: "controller.correctAnsweredQuestions",
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
                          'You have got 10 Points',
                          style: TextStyle(color: mainColor.shade800),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Tap below question numbers to view correct answers',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                       Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    color: mainColor.shade700,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text('Total', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        Text('10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    color: const Color.fromARGB(255, 11, 163, 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text('Correct', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        Text('10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    color: const Color.fromARGB(255, 253, 51, 36),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text('Wring', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        Text('10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    color: const Color.fromARGB(255, 239, 244, 92),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text('UnAnswered', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        Text('10', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ),
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
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}