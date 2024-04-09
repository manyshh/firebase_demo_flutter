import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_flutter/screens/dashboard.dart';
import 'package:firebase_demo_flutter/screens/dashboardHome.dart';
import 'package:firebase_demo_flutter/screens/login_page.dart';
import 'package:firebase_demo_flutter/screens/registration_page.dart';
import 'package:firebase_demo_flutter/screens/splash_screen.dart';
import 'package:firebase_demo_flutter/utils/colors_app.dart';
import 'package:firebase_demo_flutter/utils/light_theme.dart';
import 'package:firebase_demo_flutter/utils/routes.dart';
import 'package:firebase_demo_flutter/utils/string_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final lightTheme = LightTheme();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: String_App().appname,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch:
            lightTheme.createMaterialColor(Colors_App().pincodecolor),
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors_App().whitecolor,
      ),
      initialRoute: Routes().splashPage,
      routes: {
        Routes().splashPage: (context) => SplashPage(),
        Routes().loginPage: (context) => const LoginPage(),
        Routes().registrationForm: (context) => RegistrationForm(),
        Routes().dashboardPage: (context) => DashBoardPage(),
        Routes().dashboardHome: (context) => DashBoardHome(),
      },
    );
  }
}
