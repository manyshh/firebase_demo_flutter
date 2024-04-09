import 'dart:io';

import 'package:firebase_demo_flutter/screens/diagnostics.dart';
import 'package:firebase_demo_flutter/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors_app.dart';
import '../utils/custom_bottom_bar.dart';
import 'dashboardHome.dart';
import 'maintenance.dart';

class DashBoardPage extends StatefulWidget {
  String routeName = '/DashBoardPage';

  DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  String classname = 'DashBoardPage';

  bool changeClass = false;

  int pageIndex = 3;
  String actionBarName = 'Profile';

  int _selectedIndex = 0;

  final _inactiveColor = Colors_App().blackcolor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> onBackPress() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors_App().whitecolor,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          final navigator = Navigator.of(context);
          // Show the dialog box
          bool value = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                    'Are you sure you want to exit the application?'),
                content: const Text('Your data will be lost!!'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      setState(() {});
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          if (value) {
            if (!mounted) return;
            Navigator.pop(context, true);
          }
        },
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: _buildBottomBar(),
            body: Container(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: MediaQuery.of(context).size.height / 12,
      backgroundColor: Colors_App().pincodecolor,
      selectedIndex: _selectedIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
        if (index == 0) {
          actionBarName = 'Dashboard';
        } else if (index == 1) {
          actionBarName = 'Maintenance';
        } else if (index == 2) {
          actionBarName = 'Diagnostics';
        } else if (index == 3) {
          actionBarName = 'Settings';
        }
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Dashboard'),
          activeColor: Colors_App().whitecolor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.miscellaneous_services),
          title: const Text("Maintenance"),
          activeColor: Colors_App().whitecolor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.check_circle),
          title: const Text('Diagnostics'),
          activeColor: Colors_App().whitecolor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: Colors_App().whitecolor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    DashBoardHome(),
    const Maintenance(),
    const Diagnostics(),
    const Settings(),
  ];
}
