import 'package:amit_quiz/cubit/question_cubit.dart';
import 'package:amit_quiz/cubit/quiz_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/model/category_model.dart';
import 'package:amit_quiz/model/question_model.dart';
import 'package:amit_quiz/widgets/answer_card.dart';
import 'package:amit_quiz/widgets/content_area.dart';
import 'package:amit_quiz/widgets/default_button.dart';
import 'package:amit_quiz/widgets/error_state_card.dart';
import 'package:amit_quiz/widgets/quiz_app_bar.dart';
import 'package:amit_quiz/widgets/screen_background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final selectedCategory =
        ModalRoute.of(context)?.settings.arguments as CategoryModel?;
    int categoryId = selectedCategory == null ? 1 : selectedCategory.id;
    context.read<QuestionCubit>().getQuestions(categoryId);
    return const QuizScreen();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        ModalRoute.of(context)?.settings.arguments as CategoryModel?;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: QuizAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
            shape:
                StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
          ),
          child: Text(selectedCategory?.name ?? 'Apppp'),
        ),
        showActionIcon: true,
        titleWidget: const Text(
          'Q. ',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
      body: BlocBuilder<QuestionCubit, AppStates>(
        builder: (_, state) {
          if (state is GetQuestionSuccessState) {
            return BackgroundDecoration(
              child: Column(
                children: [
                  Expanded(child: QuizBody(questions: state.questions)),
                  QuizFooter(questions: state.questions)
                ],
              ),
            );
          }
          if (state is GetQuestionErrorState) {
            return ErrorStateCard(errorText: state.error);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// Quiz Body
class QuizBody extends StatelessWidget {
  final List<QuestionModel> questions;
  const QuizBody({super.key, required this.questions});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is QuizIndexState) {
          var currentQuestion = questions[state.currentIndex];
          return Expanded(
            child: ContentArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text(
                      currentQuestion.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    ListView.separated(
                      itemCount: currentQuestion.answers.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 25),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final answer = currentQuestion.answers[index];
                        return AnswerCard(
                          isSelected: false,
                          onTap: () {},
                          answer: '${answer.id}. ${answer.value}',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// Quiz Footer
class QuizFooter extends StatelessWidget {
  final List<QuestionModel> questions;
  const QuizFooter({super.key, required this.questions});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is QuizIndexState) {
          return ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: true,
                      child: DefaultButton(
                        onPressed: () {
                          context.read<QuizCubit>().updateQuizIndex(state.currentIndex);
                        },
                        title: '${state.currentIndex} Next',
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Center(child: Text(""));
      },
    );
  }
}
