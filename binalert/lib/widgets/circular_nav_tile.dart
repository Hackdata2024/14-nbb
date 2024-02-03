import 'package:flutter/material.dart';


class CircularNavTile extends StatefulWidget {
  final String title;
  final Widget icon;
  CircularNavTile({super.key, required this.title, required this.icon});

  @override
  State<CircularNavTile> createState() => _CircularNavTileState();
}

class _CircularNavTileState extends State<CircularNavTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Colors.transparent, // Adjust the opacity for the blur
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 9,
                  ),
                  ClipOval(
                    child: Container(
                      width: 100, // Adjust the size of the circular area
                      height: 100, // Adjust the size of the circular area
                      color: Colors.transparent,
                      child: CircleAvatar(child: widget.icon,backgroundColor: Colors.white,),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(8.0), // Add padding to the label
                    child: Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
