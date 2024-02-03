import 'package:binalert/screens/BottomNavBarScreens/dashboard/four_item_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(height: 10), // Add space on top
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
            const SizedBox(height: 20), // Add space between title and list
            Expanded(
              child: _buildRecentGainersSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentGainersSection(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
          child: FourItemWidget(), // Replace with your widget
        );
      },
    );
  }
}
