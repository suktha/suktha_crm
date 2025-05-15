import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/bindings/initial_bindings.dart';
import 'package:work_Force/controllers/global_controller.dart';
import 'package:work_Force/controllers/settings_controller.dart';
import 'package:work_Force/controllers/theme_controller.dart';
import 'package:work_Force/firebase_options.dart';
import 'package:work_Force/utils/Services/firebase_push_notification_services.dart';
import 'package:work_Force/utils/Services/local_notification_services.dart';
import 'package:work_Force/utils/Services/permission_services.dart';
import 'package:work_Force/utils/Services/sharedpref_services.dart';
import 'package:work_Force/utils/dependency_injection.dart';
import 'package:work_Force/view/bottom_navigation/navbar_controller.dart';
import 'package:work_Force/view/screens/login/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() => PermissionServices().init());
    LocalNotificationService localNotificationService = LocalNotificationService();
  await localNotificationService.init();
  await SharedPreferencesService.instance.init();
  await FirebasePushNotificationServices().initNotification();

  Get.put(GlobalController());
  Get.put(SettingsController());
    Get.put<NavigationController>(NavigationController());



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
        initialBinding: InitialBinding(),
        theme: ThemeData(scaffoldBackgroundColor: Colors.white, useMaterial3: false),
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
