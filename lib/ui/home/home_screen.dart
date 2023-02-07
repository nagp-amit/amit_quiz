import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/ui/home/widgets/category_tab.dart';
import 'package:amit_quiz/ui/home/widgets/results_tab.dart';
import 'package:amit_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/cubit/cubits.dart';

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