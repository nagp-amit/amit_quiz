import 'package:amit_quiz/model/models.dart';
import 'package:amit_quiz/navigation/routes.dart';
import 'package:amit_quiz/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryTab({super.key, required this.categories});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
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
