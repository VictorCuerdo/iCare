import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icare/ui/homepage.dart'; // Replace with the name of your home page file

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 2), onDoneLoading);
  }

  void onDoneLoading() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with your own logo image path
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Add a circular loading indicator
          ],
        ),
      ),
    );
  }
}
