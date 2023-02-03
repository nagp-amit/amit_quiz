import 'package:amit_quiz/cubit/category_cubit.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/widgets/card_item.dart';
import 'package:amit_quiz/widgets/default_appbar.dart';
import 'package:amit_quiz/widgets/quiz_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit()..getCategories(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: DefaultAppBar(
          title: 'Quiz App',
          context: context,
        ),
        drawer: const QuizDrawer(),
        body: BlocBuilder<CategoryCubit, AppStates>(
          builder: (_, state) {
            if (state is GetCategorySuccessState) {
              return TabBarView(children: [
                Expanded(
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
                            itemCount: state.categories.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 10, left: 10),
                                child: InkWell(
                                    onTap: () => {},
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 24),
                    Text(state.error, style: const TextStyle(fontSize: 24)),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
