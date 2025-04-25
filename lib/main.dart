import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/controllers/settings_controller.dart';
import 'package:suktha_crm/controllers/theme_controller.dart';
import 'package:suktha_crm/firebase_options.dart';
import 'package:suktha_crm/utils/Services/firebase_push_notification_services.dart';
import 'package:suktha_crm/utils/Services/local_notification_services.dart';
import 'package:suktha_crm/utils/Services/permission_services.dart';
import 'package:suktha_crm/utils/Services/sharedpref_services.dart';
import 'package:suktha_crm/utils/dependency_injection.dart';
import 'package:suktha_crm/view/screens/login/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() => PermissionServices().init());
  await SharedPreferencesService.instance.init();
  await FirebasePushNotificationServices().initNotification();

  Get.put(GlobalController());
  Get.put(SettingsController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DependencyInjection.init();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (cMainScreenontext, orientation, deviceType) => GetMaterialApp(
        home: SplashScreen(),
        theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: false),
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
