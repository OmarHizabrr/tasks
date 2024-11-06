import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:socialledger_new/screen/AppPages.dart';
import 'package:socialledger_new/screen/widget/AppTheme.dart';

// إضافة مكتبة Firebase Realtime Database
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';


import 'package:firebase_messaging/firebase_messaging.dart';



// استيراد الملفات بشكل شرطي حسب النظام الأساسي
import 'firebase_messaging_stub.dart'
    if (dart.library.html) 'firebase_messaging_web.dart'
    if (dart.library.io) 'firebase_messaging_mobile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // هذا السطر مهم للتهيئة الصحيحة
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // هذا السطر يحدد خيارات Firebase
  );
  // تحديد بيئة التشغيل
  if (kIsWeb) {
    // تسجيل Service Worker عند التشغيل على الويب
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken();
    registerServiceWorker();
  } else {
    // إعداد Firebase Cloud Messaging للهاتف
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');
  }

  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
       return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      title: "To-Do List",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
