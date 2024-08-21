import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:flutter/material.dart';

class CarouselIndicators extends StatefulWidget {
  const CarouselIndicators({super.key});

  @override
  State<CarouselIndicators> createState() => _CarouselIndicatorsState();
}

class _CarouselIndicatorsState extends State<CarouselIndicators> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: CustomTheme.bluePrimaryColor,
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: CustomTheme.bluePrimaryColor,
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: CustomTheme.bluePrimaryColor,
              borderRadius: BorderRadius.circular(10)),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8),
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: CustomTheme.bluePrimaryColor,
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }
}
