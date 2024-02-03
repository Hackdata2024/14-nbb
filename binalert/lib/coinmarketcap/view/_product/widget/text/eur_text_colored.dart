import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/core/constants/color/color_constant.dart';
import 'package:binalert/coinmarketcap/core/extension/context_extension.dart';
import 'package:binalert/coinmarketcap/product/init/locale/project_keys.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';

class EurTextColored extends StatelessWidget {
  const EurTextColored({required this.crypto, super.key});
  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.smallPadAll,
      child: Text(
        ProjectKeys.eur,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: crypto.quote?.uSD?.percentChange24h.toString().substring(0, 1) == '-'
                  ? ProjectColors.cabaret
                  : ProjectColors.jungleGreen,
            ),
      ),
    );
  }
}
