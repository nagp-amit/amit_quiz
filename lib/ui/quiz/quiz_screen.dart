import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/question_cubit.dart';
import 'package:amit_quiz/cubit/quiz_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/model/category_model.dart';
import 'package:amit_quiz/model/question_model.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/widgets/default_button.dart';
import 'package:amit_quiz/widgets/error_state_card.dart';
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
    return WillPopScope(
      child: Scaffold(
        body: BlocBuilder<QuestionCubit, AppStates>(builder: (_, state) {
          if (state is GetQuestionSuccessState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [mainColor.shade800, mainColor.shade300],
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                        ),
                      )),
                  Positioned(
                    top: 50,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedCategory?.name ?? '')
                              // Text('Questions: ${selectedPageIndex + 1}/${widget.quizData!.questionRef!.length}', style: boldTextStyle(color: white, size: 20)),
                            ]),
                        DefaultButton(
                          title: 'End Quiz',
                          color: mainColor,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.result);
                          },
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: MediaQuery.of(context).size.height * 0.20,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [QuizBody(questions: state.questions)]),
                    ),
                  )
                ],
              ),
            );
          }
          if (state is GetQuestionErrorState) {
            return ErrorStateCard(errorText: state.error);
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
      onWillPop: () {
        return Future.value(false);
      },
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
          return SingleChildScrollView(
            child: Column(
              children: [
                QuizQuestionComponent(question: currentQuestion),
                Visibility(
                  visible: state.currentIndex < questions.length,
                  child: DefaultButton(
                    onPressed: () {
                      context
                          .read<QuizCubit>()
                          .updateQuizIndex(state.currentIndex);
                    },
                    title: '${state.currentIndex} Next',
                  ),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

//ignore: must_be_immutable
class QuizQuestionComponent extends StatefulWidget {
  int _selectedOptionIndex = -1;
  final QuestionModel? question;

  QuizQuestionComponent({super.key, this.question});

  @override
  QuizQuestionComponentState createState() => QuizQuestionComponentState();
}

class QuizQuestionComponentState extends State<QuizQuestionComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('addQuestion', textAlign: TextAlign.center),
        Column(
          children: List.generate(widget.question!.answers.length, (index) {
            String mData = widget.question!.answers[index].value;
            return InkWell(
                onTap: () {
                  setState(() {
                    widget._selectedOptionIndex = index;
                  });
                  context.read<QuizCubit>().saveQuizProgress(
                      widget.question!.id, widget.question!.answers[index].id);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: widget._selectedOptionIndex == index
                        ? mainColor.shade500
                        : const Color(0xFF090909),
                  ),
                  child: Text(mData),
                ));
          }),
        ),
      ],
    );
  }
}

Decoration boxDecorationWithRoundedCorners({
  Color backgroundColor = Colors.white,
  BorderRadius? borderRadius,
  LinearGradient? gradient,
  BoxBorder? border,
  List<BoxShadow>? boxShadow,
  DecorationImage? decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
}) {
  return BoxDecoration(
    color: backgroundColor,
    borderRadius: borderRadius,
    gradient: gradient,
    border: border,
    boxShadow: boxShadow,
    image: decorationImage,
    shape: boxShape,
  );
}
