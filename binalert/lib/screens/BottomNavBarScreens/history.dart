import 'dart:convert';
import 'package:binalert/screens/BottomNavBarScreens/dashboard/four_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://10.8.24.2:3000/history'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return List<dynamic>.from(data); // Assuming your data is a list of strings
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    // Limiting data to 10 items (you can change the limit)
                    final limitedData = snapshot.data!.take(20).toList();

                    return ListView.builder(
                      itemCount: limitedData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
                          child: FourItemWidget(data: limitedData[index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


