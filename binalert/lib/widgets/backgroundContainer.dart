import 'package:flutter/material.dart';
import 'package:binalert/constants/color_constants.dart';

class backgroundContainer extends StatelessWidget {
  final Widget child;
  const backgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x3500D0E4), // 30% transparency
                  Colors.transparent,
                ],
              ),
            ),
        ),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.3,
        //   decoration: BoxDecoration(color: Color.fromARGB(77, 255, 255, 255)),
        // ),

        
            Container(
                      child: child,
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
            
        
      ],
    );
  }
}
