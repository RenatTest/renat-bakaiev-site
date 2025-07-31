import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:renat_bakaiev_project/firebase/firebase_api.dart';
import 'routes/routes.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Background");
    print(message.notification!.title);
    print(message.notification!.body);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDP4V_HFc51hpfW6onG8a-CPg2z0Ae7KSY",
          projectId: "renat-bakaiev-site-b7b40",
          messagingSenderId: "735151504836",
          appId: "1:735151504836:web:864e4014b23b868edd3891"));

  await FirebaseApi().initNotifications();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Foreground");
      print(message.notification!.title);
      print(message.notification!.body);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.homePage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
