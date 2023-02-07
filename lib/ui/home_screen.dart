import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/category_cubit.dart';
import 'package:amit_quiz/cubit/history_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/model/category_model.dart';
import 'package:amit_quiz/model/result_model.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/widgets/card_item.dart';
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
        appBar: AppBar(
          title: const Text('Quiz App'),
          backgroundColor: mainColor.shade800,
        ),
        drawer: const QuizDrawer(),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
              indicatorColor: mainColor,
              onTap: (index) {
                if (index == 1) {
                  context.read<HistoryCubit>().getResults();
                }
              },
              tabs: [
                Tab(
                    child: Text(
                  "Quiz",
                  style: TextStyle(color: mainColor.shade800),
                )),
                Tab(
                    child: Text(
                  "Result",
                  style: TextStyle(color: mainColor.shade800),
                )),
              ],
            ),
            body: BlocConsumer<CategoryCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetCategorySuccessState) {
            return TabBarView(children: [CategoryTab(categories: state.categories), ResultTab(categories: state.categories)]);
          }
          return const Center(child: CircularProgressIndicator());})
          ),
        ));
  }
}

class CategoryTab extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryTab({super.key, required this.categories});
  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: categories.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 10, left: 10),
                            child: InkWell(
                                onTap: () => {
                                      Navigator.pushNamed(context, Routes.quiz,
                                          arguments: categories[index])
                                    },
                                child: CardItem(
                                  category: categories[index],
                                )),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
  }
}

class ResultTab extends StatelessWidget {
  final List<CategoryModel> categories;
  const ResultTab({super.key, required this.categories});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetHistorySuccessState) {
            return Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.results.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor.shade600),
                    child: ResultCard(result: state.results[index], categories: categories),
                  ),
                );
              },
            ));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class ResultCard extends StatelessWidget {
  final List<CategoryModel> categories;
  final ResultModel result;
  const ResultCard({super.key, required this.result, required this.categories});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        'Category:   ${categories.where((x) => x.id.toString() == result.categoryId).first.name}',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Score: ${result.score}    Correct: ${result.correctCount}',
          style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.keyboard_arrow_right,
          color: Colors.white, size: 30.0),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailPage(lesson: lesson)));
      },
    );
  }
}
