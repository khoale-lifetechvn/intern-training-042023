import 'package:flutter/material.dart';
import 'package:travel_social_app/screens/mainscreen.dart';
import 'package:travel_social_app/utils/constants.dart';

void main() => runApp((const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Constants.lightTheme,
      home: const MainScreen(),
    );
  }
}
