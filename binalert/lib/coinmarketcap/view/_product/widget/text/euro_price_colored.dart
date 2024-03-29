import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/core/constants/color/color_constant.dart';
import 'package:binalert/coinmarketcap/product/features/conversion/currency_conversion.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';

class EurPriceColored extends StatelessWidget {
  const EurPriceColored({required this.crypto, super.key});
  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Text(
      //CurrencyConversion().convertUsdToEuro(crypto.quote?.uSD?.price ?? 0),
      crypto.quote?.uSD?.price?.toStringAsPrecision(3) ?? "0",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: crypto.quote?.uSD?.percentChange24h.toString().substring(0, 1) == '-'
                ? ProjectColors.cabaret
                : ProjectColors.jungleGreen,
          ),
    );
  }
}
