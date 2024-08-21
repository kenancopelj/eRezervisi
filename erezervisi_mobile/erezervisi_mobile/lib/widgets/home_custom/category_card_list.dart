import 'package:erezervisi_mobile/models/responses/category/categories.dart';
import 'package:erezervisi_mobile/widgets/home_custom/category_card.dart';
import 'package:flutter/material.dart';

class CategoryCardList extends StatefulWidget {
  final Categories categories;
  final void Function(num) onClick;


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
          // Wrap ListView.builder with Expanded
          child: SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal, // Set scroll direction to horizontal
              itemCount: widget.categories.categories.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    widget.onClick(widget.categories.categories[index].id);
                    setState(() {
                      selectedIndex = index;
                    });
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
