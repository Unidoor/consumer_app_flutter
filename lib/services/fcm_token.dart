import 'package:firebase_messaging/firebase_messaging.dart';

class FCMToken {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var tokenId;
  Future<String> getUserToken() async {
    // if (Platform.isIOS) checkforIosPermission();
    await messaging.getToken().then((token) {
      return token;
    });
  }

  // void checkforIosPermission() async {
  //   await messaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));
  //   await messaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }

  Future<void> getToken() async {
    tokenId = await getUserToken();
    print(tokenId);
  }
}
