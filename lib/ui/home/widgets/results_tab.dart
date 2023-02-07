import 'package:amit_quiz/config/colors.dart';
import 'package:amit_quiz/cubit/cubits.dart';
import 'package:amit_quiz/cubit/states.dart';
import 'package:amit_quiz/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    decoration: BoxDecoration(color: mainColor.shade600),
                    child: ResultCard(
                        result: state.results[index], categories: categories),
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
      subtitle: Text(
          'Score: ${result.score}    Correct: ${result.correctCount}',
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
