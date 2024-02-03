import 'package:binalert/models/crypto.dart';
import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/repositories/getdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    int totalScore =
        context.read<FirebaseRepository>().userModel.userStat.totalScore;
    int totalQuizTaken =
        context.read<FirebaseRepository>().userModel.userStat.totalQuizTaken;
    double avgScore = double.parse(
        ((totalScore / (totalQuizTaken * 15)) * 100).toStringAsFixed(2));

    print(totalScore);
    print(totalQuizTaken);
    print(avgScore);
    print("height : ${MediaQuery.of(context).size.width * 0.6}");

    // Fetch cryptocurrency data and print it
    // final cryptoService = CryptoService();

    // cryptoService.getCryptoData("BTC").then((cryptoData) {
    //   if (cryptoData != null) {
    //     print("Crypto Data: ${cryptoData.toJson()}");
    //   } else {
    //     print("Failed to fetch crypto data: Data is null");
    //   }
    // }).catchError((error) {
    //   print("Error fetching crypto data: $error");
    // });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("hello"),
            ],
          ),
        ),
      ),
    );
  }
}
