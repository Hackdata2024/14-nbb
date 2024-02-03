import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';
import 'package:binalert/coinmarketcap/view/tradingview/view/trading_page.dart';

class RoutingWithCore {
  factory RoutingWithCore() {
    return _routingWithCore;
  }
  RoutingWithCore._internal();
  static final RoutingWithCore _routingWithCore = RoutingWithCore._internal();

  static MaterialPageRoute<TradingPage> goTradingPage(Crypto crypto) {
    return MaterialPageRoute<TradingPage>(
      builder: (context) {
        return TradingPage(
          crypto: crypto,
        );
      },
    );
  }
}
