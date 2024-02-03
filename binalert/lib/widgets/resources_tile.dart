import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:binalert/constants/color_constants.dart';

class ResourcesTile extends StatelessWidget {
  final String fileName;
  final String imageUrl;

  const ResourcesTile(
      {super.key, required this.fileName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 130,
                color: Color.fromARGB(255, 78,78,78),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 130, // Set the desired height
                        child: Image(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                      child: Text(
                        fileName,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow
                            .ellipsis, // Optional: Handle text overflow
                        maxLines: 3, // Optional: Set a maximum number of lines
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(Icons.arrow_circle_right_rounded,
                          color: Color.fromARGB(255, 206, 255, 68), size: 30),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 130,
              width: 10,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 206, 255, 68),
              ),
            )
          ],
        ),
      ],
    );

    // return Stack(
    //   children: <Widget>[
    //     Center(
    //         child: Container(
    //       width: MediaQuery.of(context).size.width * 0.45,
    //       height: MediaQuery.of(context).size.width * 0.65,
    //       child: ClipRRect(
    //         // Wrap the Container with ClipRRect
    //         borderRadius: BorderRadius.circular(20.0),
    //         child: BackdropFilter(
    //           filter: ImageFilter.blur(
    //               sigmaX: 10, sigmaY: 10), // Adjust the blur values
    //           child: Container(
    //             color: Color.fromARGB(32, 255, 255,
    //                 255), // Adjust the opacity for the glassy effect
    //           ),
    //         ),
    //       ),
    //     )),
    //     Center(
    //       child: Container(
    //         width: MediaQuery.of(context).size.width * 0.42,
    //         height: MediaQuery.of(context).size.width * 0.62,
    //         decoration: BoxDecoration(
    //           color:
    //               Colors.transparent, // Adjust the opacity for the glassy box
    //           borderRadius: BorderRadius.circular(20.0),
    //         ),
    //         child: Center(
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(20.0),
    //                   child: Image(
    //                     image: NetworkImage(imageUrl),
    //                     height: MediaQuery.of(context).size.width * 0.45,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //               // Add some spacing between the image and text
    //               Container(
    //                 padding: EdgeInsets.all(
    //                     2.0), // Add padding to the text container
    //                 child: Text(
    //                   maxLines: 2,
    //                   textAlign: TextAlign.center,
    //                   overflow: TextOverflow.ellipsis,
    //                   fileName,
    //                   style: TextStyle(
    //                     color: Colors.white, // Text color
    //                     fontWeight: FontWeight.bold, // Text style
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
