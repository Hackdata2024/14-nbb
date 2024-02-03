import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/product/init/locale/project_keys.dart';
import 'package:binalert/coinmarketcap/product/widget/text-area/custom_multi_text_area.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';

class DayHighView extends StatelessWidget {
  const DayHighView({
    required this.crypto,
    super.key,
  });

  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return CustomMultiTextArea(
      title: ProjectKeys.twentyFourHourHighEuro,
      description: crypto.quote?.uSD?.percentChange24h?.toStringAsFixed(2) ?? ProjectKeys.notFound,
    );
  }
}
