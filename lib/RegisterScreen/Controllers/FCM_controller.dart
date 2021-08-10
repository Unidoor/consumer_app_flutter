import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMController extends GetxController {
  RxString fCMToken = ''.obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTokenController();
  }

  Future<void> getTokenController() async {
    fCMToken.value = await messaging.getToken();
    print("FCM Controller Token ${fCMToken.value}");
  }
}
