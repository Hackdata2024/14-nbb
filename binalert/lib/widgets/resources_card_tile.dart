import 'package:flutter/material.dart';

class ResourcesCartTile extends StatelessWidget {
  final String fileName;
  final String imageUrl;

  const ResourcesCartTile(
      {super.key, required this.fileName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 170,
      color: Color.fromARGB(255, 109, 109, 109),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image(
                  image: NetworkImage(imageUrl),
                  height: 150,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Text(
                fileName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ]),
    );
  }
}
