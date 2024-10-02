import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final num? value;
  final Widget? content;
  final double? width;

  const DashboardCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.value,
      this.content,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: width ?? 510,
        height: content != null ? 500 : 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: CustomTheme.homeCardTitleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle,
                  style: CustomTheme.homeCardSubTitleTextStyle,
                ),
              ),
              if (value != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$value",
                    style: CustomTheme.homeCardValueTextStyle,
                  ),
                ),
              content ?? const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
