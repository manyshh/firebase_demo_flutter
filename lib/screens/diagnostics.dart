import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_flutter/utils/routes.dart';
import 'package:flutter/material.dart';

class Diagnostics extends StatefulWidget {
  const Diagnostics({super.key});

  @override
  State<Diagnostics> createState() => _DiagnosticsState();
}

class _DiagnosticsState extends State<Diagnostics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnostics"),
        centerTitle: true,
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
        child: Text(
          "Diagnostics",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
