import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/product/init/locale/project_keys.dart';

class TabbarConstants {
  factory TabbarConstants() {
    return _tabbarConstants;
  }

  TabbarConstants._internal();
  static final TabbarConstants _tabbarConstants = TabbarConstants._internal();

  static const tabbarItems = [
    Text(ProjectKeys.trend),
    Text(ProjectKeys.technicals),
    Text(ProjectKeys.transaction),
  ];
}
