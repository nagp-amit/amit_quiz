import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/quiz_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/ui/home_screen.dart';
import 'package:amit_quiz/widgets/content_area.dart';
import 'package:amit_quiz/widgets/default_button.dart';
import 'package:amit_quiz/widgets/quiz_app_bar.dart';
import 'package:amit_quiz/widgets/screen_background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const HomeScreen();

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
                            '${state.answeredQuestions.length} Congratulations',
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