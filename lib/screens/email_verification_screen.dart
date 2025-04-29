import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashboard_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? timer;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (time) {
      checkEmailVerification();
    });

    super.initState();
  }

  checkEmailVerification() {
    FirebaseAuth.instance.currentUser!.reload();

    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      timer?.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return DashboardScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        backgroundColor: Colors.deepOrange,
      ),

      body: Column(
        spacing: 10,
        children: [
          Text("Email Verification"),
          Text(
            "An email has been sent to you.\nPlease verify your account",
            textAlign: TextAlign.center,
          ),

          SpinKitWave(color: Colors.purple),

          Text("Didn't get Email ?"),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser!.sendEmailVerification();
            },
            child: const Text('Resend Email'),
          ),
        ],
      ),
    );
  }
}
