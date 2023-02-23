import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../controller/binding/binding.dart';
import '../../route.dart' as app_route;
import 'core/common/app_config.dart';
import 'core/common/app_fonts.dart';
import 'core/common/color.dart';

///---------------------------------------------- Performance
/// import 'package:sentry/sentry.dart';
//
// final transaction = Sentry.startTransaction('processOrderBatch()', 'task');
//
// try {
//   await processOrderBatch(transaction);
// } catch (exception) {
//   transaction.throwable = exception;
//   transaction.status = SpanStatus.internalError();
// } finally {
//   await transaction.finish();
// }
//
// Future<void> processOrderBatch(ISentrySpan span) async {
//   // span operation: task, span description: operation
//   final innerSpan = span.startChild('task', description: 'operation');
//
//   try {
//     // omitted code
//   } catch (exception) {
//     innerSpan.throwable = exception;
//     innerSpan.status = SpanStatus.notFound();
//   } finally {
//     await innerSpan.finish();
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  infoApp();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await FirebaseMessaging.instance.getToken().then((value) async {

  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  //FirebaseCrashlytics.instance.crash();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  configLoading();
}


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}
Future<void> infoApp() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppConfig.appName=packageInfo.appName;
  AppConfig.slugNotification=packageInfo.appName;
  AppConfig.appPackageName=packageInfo.packageName;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: ThemeData(
        fontFamily: AppFont.JollyGood,
      ),
      home: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (BuildContext context, child) => MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: AppFont.JollyGood,
          ),
          themeMode: ThemeMode.light,
          builder: EasyLoading.init(),
          initialRoute: app_route.NavigatorRoutes.splash,
          onGenerateRoute: app_route.Router.generateRoute,
        ),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 20.0
    ..radius = 7.0
    ..progressColor = Colors.yellow
    ..backgroundColor = ColorChanged.primaryColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
