import 'package:erezervisi_mobile/shared/style.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final bool selected;
  final String title;
  const CategoryCard({super.key, required this.selected, required this.title});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        width: 85,
        height: 45,
        decoration: BoxDecoration(
          color: widget.selected ? Colors.grey[600] : Style.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
