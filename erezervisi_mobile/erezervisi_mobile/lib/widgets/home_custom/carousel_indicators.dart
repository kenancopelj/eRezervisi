import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:flutter/material.dart';

class CarouselIndicators extends StatefulWidget {
  final int length;
  const CarouselIndicators({super.key, required this.length});

  @override
  State<CarouselIndicators> createState() => _CarouselIndicatorsState();
}

class _CarouselIndicatorsState extends State<CarouselIndicators> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Container(
          margin: const EdgeInsets.only(right: 8),
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: CustomTheme.bluePrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
