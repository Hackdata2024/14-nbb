import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:binalert/bloc/auth/auth_bloc.dart';
import 'package:binalert/bloc/firebase_storage/firebase_storage_bloc.dart';
import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/repositories/firebase_storage_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:binalert/firebase_options.dart';
import 'package:binalert/screens/auth/login.dart';
import 'package:workmanager/workmanager.dart';
import 'package:binalert/notification_service.dart';
import 'package:http/http.dart' as http;

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("Task executing first time");
    NotificationServices notificationServices = NotificationServices();
    notificationServices.initialiseNotification();
    notificationServices.sendNotification((-1), "Pump Detector Running");

    //var url = Uri.parse('http://10.100.40.255:3000');
    var count = 0;
    while (count >= 0) {
      fetchData(count);
      count = count + 100;
      await Future.delayed(Duration(milliseconds: 10000));
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Workmanager().initialize(callbackDispatcher);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Workmanager().registerOneOffTask("taskOne", "backUp",
        initialDelay: Duration(seconds: 5));

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseRepository>(
            create: (context) => FirebaseRepository()),
        RepositoryProvider<FirebaseStoreageRepo>(
            create: (context) => FirebaseStoreageRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
          BlocProvider<FirebaseStorageBloc>(
              create: (BuildContext context) => FirebaseStorageBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          theme: ThemeData(
            fontFamily: 'Outfit',
            appBarTheme: AppBarTheme(
              color: Color.fromARGB(255, 7, 59, 118), // Darker blue color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20.0), // Adjust the radius as needed
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void fetchData(int count) async {
  final String url =
      'http://10.8.24.2:3000/5minpump'; // Replace with your API endpoint

  try {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Initialize FlutterLocalNotificationsPlugin
      if (data != null) {
        // Display a notification for each line of data
        int i = 0;
        print(data);

        for (List<dynamic> innerList in data) {
          // Iterate over the inner array
          
            NotificationServices notificationServices = NotificationServices();
            notificationServices.initialiseNotification();
            notificationServices.sendNotification((count + i), innerList[1]);
            i++;
          
        }
      }
    } else {
      print('Failed with status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
