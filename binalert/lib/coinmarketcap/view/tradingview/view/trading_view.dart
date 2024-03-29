import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/core/extension/context_extension.dart';
import 'package:binalert/coinmarketcap/view/_product/tabbar/trading_tab_views.dart';
import 'package:binalert/coinmarketcap/view/_product/tabbar/trading_tabbar_constants.dart';
import 'package:binalert/coinmarketcap/view/_product/tabbar/trading_view_tabbars.dart';
import 'package:binalert/coinmarketcap/view/_product/widget/appbar/tradingview_app_bar.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';

class TradingView extends StatelessWidget {
  const TradingView({required this.crypto, super.key});
  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TradingAppBar(crypto: crypto),
      body: DefaultTabController(
        length: TabbarConstants.tabbarItems.length,
        child: SizedBox(
          height: context.bodyHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TradingviewTabbars(),
              TradingTabViews(crypto: crypto),
            ],
          ),
        ),
      ),
    );
  }
}
