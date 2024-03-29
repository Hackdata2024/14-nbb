import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/core/constants/color/color_constant.dart';

class TitleMediumText extends StatelessWidget {
  const TitleMediumText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: ProjectColors.white,
          ),
    );
  }
}
