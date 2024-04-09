import 'package:flutter/material.dart';

class LoginCardWidget extends StatelessWidget {
  const LoginCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          Text(
            "Sign In",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          Text("Email Address"),

        ],
      ),
    );
  }



}
