import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suktha_crm/controllers/global_controller.dart';
import 'package:suktha_crm/controllers/theme_controller.dart';
import 'package:suktha_crm/utils/Services/sharedpref_services.dart';
import 'package:suktha_crm/validations/dependency_injection.dart';
import 'package:suktha_crm/view/screens/login/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();
  Get.put(GlobalController());

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
