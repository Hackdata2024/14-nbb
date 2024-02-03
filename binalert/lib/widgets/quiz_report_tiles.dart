import 'package:flutter/material.dart';

class QuizReportTile extends StatelessWidget {
  const QuizReportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      color: Color.fromARGB(255, 78, 78, 78),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: Color.fromARGB(255, 206, 255, 68),
              size: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Score : 9 out of 15",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "01/10/2004",
                  style: TextStyle(
                      color: Color.fromARGB(255, 24, 24, 24), fontSize: 12),
                )
              ],
            ),
            Icon(
              Icons.arrow_circle_right_rounded,
              color: Color.fromARGB(255, 206, 255, 68),
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
