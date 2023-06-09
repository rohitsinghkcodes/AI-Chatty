import 'dart:async';
import 'package:flutter/material.dart';

import 'chatScreen.dart';

class SplashScreen extends StatefulWidget {
  // static const id = "splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF8C52FF), Color(0xFF5CE1E6)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    height: 40,
                    child: Image.asset('images/logo_main.png'),
                  ),
                ),
                const Text(
                  'Powered by ChatGPT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 1500), () async {
      navigateUser(); //It will redirect  after  1.5 seconds
    });
  }

  void navigateUser() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const ChatScreen()));
  }
}
