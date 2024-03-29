import 'package:flutter/material.dart';
import 'package:binalert/coinmarketcap/core/init/theme/dark/dark_theme.dart';
import 'package:binalert/coinmarketcap/view/home/view/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ProjectTheme().darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
