import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/firebase_options.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<GetNavigation>().navigatorKey,
      onGenerateRoute: (route) => RouteGenerator.getRoute(route),
    );
  }
}
