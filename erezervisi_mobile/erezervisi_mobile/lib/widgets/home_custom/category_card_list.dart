import 'package:erezervisi_mobile/models/responses/category/categories.dart';
import 'package:erezervisi_mobile/widgets/home_custom/category_card.dart';
import 'package:flutter/material.dart';

class CategoryCardList extends StatefulWidget {
  final Categories categories;
  final void Function(num?) onClick;

  const CategoryCardList(
      {super.key, required this.categories, required this.onClick});

  @override
  State<CategoryCardList> createState() => _CategoryCardListState();
}

class _CategoryCardListState extends State<CategoryCardList> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.categories.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (selectedIndex != index) {
                      widget.onClick(widget.categories.categories[index].id);
                      setState(() {
                        selectedIndex = index;
                      });
                    } else {
                      widget.onClick(null);
                      setState(() {
                        selectedIndex = -1;
                      });
                    }
                  },
                  child: CategoryCard(
                    title: widget.categories.categories[index].title,
                    selected: selectedIndex == index,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
