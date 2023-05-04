import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/log.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/firebase_options.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_social_app/ui/utils/constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logInfo("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logInfo('Got a message whilst in the foreground!');
    logInfo('Message data: ${message.data}');

    if (message.notification != null) {
      logInfo('Message also contained a notification: ${message.notification}');
    }
  });

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
      theme: Constants.lightTheme,
      navigatorKey: locator<GetNavigation>().navigatorKey,
      onGenerateRoute: (route) => RouteGenerator.getRoute(route),
    );
  }
}
