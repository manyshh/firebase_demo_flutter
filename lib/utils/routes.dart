import 'package:firebase_demo_flutter/screens/dashboard.dart';
import 'package:firebase_demo_flutter/screens/dashboardHome.dart';
import 'package:firebase_demo_flutter/screens/registration_page.dart';

import '../screens/login_page.dart';
import '../screens/splash_screen.dart';

class Routes {
  //#region *** common pages pages ***
  String splashPage = SplashPage().routeName;
  String loginPage = LoginPage().routeName;
  String registrationForm = RegistrationForm().routeName;
  String dashboardPage = DashBoardPage().routeName;
  String dashboardHome = DashBoardHome().routeName;

//#endregion
}
