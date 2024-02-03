import 'package:binalert/repositories/firebase_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // print(context
    //     .read<FirebaseRepository>()
    //     .userModel
    //     .userStat
    //     .userScores
    //     .toList());

    int totalScore =
        context.read<FirebaseRepository>().userModel.userStat.totalScore;
    int totalQuizTaken =
        context.read<FirebaseRepository>().userModel.userStat.totalQuizTaken;
    int dailyStreak =
        context.read<FirebaseRepository>().userModel.userStat.dailyStreak;
    bool isStreak =
        context.read<FirebaseRepository>().userModel.userStat.isStreak;
    double avgScore = double.parse(
        ((totalScore / (totalQuizTaken * 15)) * 100).toStringAsFixed(2));
    print(totalScore);
    print(totalQuizTaken);
    print(avgScore);
    print("height : ${MediaQuery.of(context).size.width * 0.6}");

    //context.read<FirebaseRepository>().getEvents();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("hello")
          ],
        )),
      ),
    );
  }
}

