import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:huggy_wuggy_wallpaper/core/common/app_color.dart';
import 'package:path_provider/path_provider.dart';
import '../core/common/app_config.dart';
import '../core/common/color.dart';
import '../main.dart';

class NotificationController extends GetxController {

  Future<void> topicSubscribe() async {
    String topic = "broadcast_${AppConfig.slugNotification}";
    print("broadcast_${AppConfig.slugNotification}");
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> topicUnSubscribe() async {
    String topic = "broadcast_${AppConfig.slugNotification}";
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> showNotificationsPlugin(
      {required RemoteNotification notification,
        required AndroidNotification android}) async {
    print(android.toMap());
    final String bigPicturePath = await _downloadAndSaveFile(
        android.imageUrl ?? 'https://via.placeholder.com/400x800',
        'bigPicture');
    print(bigPicturePath);
    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      // largeIcon: FilePathAndroidBitmap(largeIconPath),
    );
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              priority: Priority.high,
              enableLights: true,
              channelDescription: channel.description,
              playSound: true,
              icon: 'logo',
             color: ColorChanged.primaryColor,
              largeIcon: android.imageUrl == null
                  ? null
                  : FilePathAndroidBitmap(bigPicturePath),
              styleInformation: android.imageUrl == null
                  ? MediaStyleInformation()
                  : bigPictureStyleInformation,
            ),));
  }
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}