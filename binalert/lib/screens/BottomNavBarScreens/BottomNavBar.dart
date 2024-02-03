import 'dart:ui';
import 'package:binalert/screens/BottomNavBarScreens/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/repositories/firebase_storage_repo.dart';
import 'package:binalert/screens/BottomNavBarScreens/dashboard.dart';
import 'package:binalert/screens/BottomNavBarScreens/profile_page.dart';
import 'package:binalert/widgets/backgroundContainer.dart';
import 'package:binalert/widgets/binalertBar.dart';
import 'package:binalert/widgets/app_bar_drawer.dart';

class NavBarScreens extends StatefulWidget {
  const NavBarScreens({super.key});

  @override
  State<NavBarScreens> createState() => _NavBarScreensState();
}

class _NavBarScreensState extends State<NavBarScreens> {
  @override
  // ignore: must_call_super
  initState() {
    super.initState();
  }

  int index = 1;
  List<Widget> screensList = [HistoryPage(),Dashboard(),ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return backgroundContainer(
      child: Scaffold(
        drawer: AppBarDrawer(context),
        extendBodyBehindAppBar: true,
        appBar: binalertAppBar(NavBarItems[index].title, context),
        backgroundColor: Colors.transparent,
        body: screensList[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          elevation: 0,
          backgroundColor: const Color.fromARGB(
              255, 29, 29, 37), // Dark blue background color
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(
              color: Color.fromARGB(
                  255, 250, 250, 250)), // Set the color for selected icons
          unselectedIconTheme:
              IconThemeData(color: Color.fromARGB(255, 84,83,84)),
          selectedItemColor: Color.fromARGB(255, 250, 250, 250), // Set the color for selected items (icons and text)
          unselectedItemColor: Color.fromARGB(255, 84,83,84), // Set the color for unselected items (icons and text)
          iconSize: 30, // Set the size of the icons
          items: getBottomTabs(NavBarItems),
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }
}

class MyTabItem {
  String appBarTitle;
  String title;
  IconData icon;
  MyTabItem(
    this.appBarTitle,
    this.title,
    this.icon,
  );
}

List<MyTabItem> NavBarItems = [
  MyTabItem('History Screen', 'Practice', Icons.history),
  MyTabItem('Home Screen', 'Dashboard', Icons.home),  
  MyTabItem('Profile Screen', 'Profile', Icons.person),
];

List<BottomNavigationBarItem> getBottomTabs(List<MyTabItem> items) {
  return items.map((e) {
    return BottomNavigationBarItem(
        icon: Icon(e.icon),
        label: e.title,
        backgroundColor: Colors.transparent);
  }).toList();
}

