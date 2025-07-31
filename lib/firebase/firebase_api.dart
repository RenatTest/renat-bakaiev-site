// ignore: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    getDeviceToken();
  }

  Future getDeviceToken({int maxRetries = 3}) async {
    try {
      String? deviceToken;
      deviceToken = await _firebaseMessaging.getToken(
          vapidKey:
              "BAavgvEi09wNdPJbHIAMK17oUBMj0gTDn5Ez_vQvkIjwj6iWM32EjjWoBjRdFNuRxC8u8ihd8hK-XqRJ-l3p-KE");
      print('Device token: $deviceToken');
      return deviceToken;
    } catch (e) {
      if (maxRetries > 0) {
        await Future.delayed(const Duration(seconds: 10));
        return getDeviceToken(maxRetries: maxRetries - 1);
      } else {
        return null;
      }
    }
  }
}
