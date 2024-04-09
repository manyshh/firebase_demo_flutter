import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/routes.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance"),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Are you sure you want to logout?'),
                    content: const Text('Logout'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          print("Sign Out");
                          FirebaseAuth.instance.signOut().then((value) => {
                            Navigator.pushNamed(context, Routes().loginPage)
                          });
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text("Dashboard Home", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
