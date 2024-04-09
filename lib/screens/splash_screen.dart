import 'dart:async';

import 'package:firebase_demo_flutter/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../utils/colors_app.dart';
import '../utils/routes.dart';

class SplashPage extends StatefulWidget {
  String routeName = '/SplashPage';

  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  /// Lifecycle Section
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, Routes().loginPage, (route) => false);
    });
    // Navigator.pushNamedAndRemoveUntil(context, Routes().loginPage, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors_App().whitecolor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets().logo,
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width / 1.4,
              ),
              _copyright(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _copyright() {
    return const Text(
      '© Emacus Private Limited',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
