import 'package:flutter_basic/screens/login/index.dart';
import 'package:flutter_basic/services/navigation_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (context) => const LoginScreen(),
        // Add more screens here
      },
      initialRoute: "login",
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
