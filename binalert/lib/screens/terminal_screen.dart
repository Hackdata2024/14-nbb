import 'package:flutter/material.dart';


class TerminalScreen extends StatelessWidget {
  const TerminalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          child : Text("Terminal screen",
          textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                              ))
        ),
      ),
    );
  }
}