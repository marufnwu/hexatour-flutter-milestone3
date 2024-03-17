import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hexatour/core/theme/theme.dart';
import 'package:hexatour/core/utils/injection.dart';
import 'package:hexatour/services/dynamic_links.dart';
import 'package:hexatour/services/routing/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'core/utils/environment.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );

  // getToken();

  
  // setupFirebaseMessaging();
  // firebaseCloudMessagingListeners();

  await dotenv.load(fileName: Environment.fileName);

  DependencyInjuctor.inject();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DynamicLinkService dynamicLinkService = DynamicLinkService();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final router = CustomRouter();
  @override
  void initState() {
    super.initState();

    DynamicLinkService.initDynamicLink(context);
    print('nooowayyy');

    print('isit');
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          getPages: CustomRouter.routes,
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          title: 'KAKA',
          theme: ApplicationTheme.lightTheme,
        );
      },
    );
  }
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
void setupFirebaseMessaging() async {
  print('prin something');
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print(settings);
  print('tantrum');

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

void firebaseCloudMessagingListeners() {
  print('are u there');
  _firebaseMessaging.getToken().then((token) {
    print('Firebase Token: $token');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message: ${message.data}');

    if (message.notification != null) {
      print('not nulll');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message opened: $message');
  });
}

Future getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString("fcmToken", token!);
  debugPrint('FCM Notification Token ${prefs.getString('fcmToken')}');
}
