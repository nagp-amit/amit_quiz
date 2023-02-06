import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/category_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/widgets/card_item.dart';
import 'package:amit_quiz/widgets/error_state_card.dart';
import 'package:amit_quiz/widgets/quiz_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz App'), backgroundColor: mainColor.shade800,),
        drawer: const QuizDrawer(),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
              indicatorColor: mainColor,
              tabs: [
                Tab(child: Text("Quiz", style: TextStyle(color: mainColor.shade800),)),
                Tab(child: Text("Result", style: TextStyle(color: mainColor.shade800),)),
              ],
            ),
            body: BlocBuilder<CategoryCubit, AppStates>(
              builder: (_, state) {
                if (state is GetCategorySuccessState) {
                  return TabBarView(children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListView.builder(
                                itemCount: state.categories.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 10, left: 10),
                                    child: InkWell(
                                        onTap: () => {
                                              Navigator.pushNamed(
                                                  context, Routes.quiz,
                                                  arguments:
                                                      state.categories[index])
                                            },
                                        child: CardItem(
                                          category: state.categories[index],
                                        )),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //for third tab
                      height: 400,
                      color: Colors.blue,
                    )
                  ]);
                }
                if (state is GetCategoryErrorState) {
                  return ErrorStateCard(errorText: state.error);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}
