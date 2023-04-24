import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icare/ui/homepage.dart';
import 'package:icare/widgets/loading_logo.dart'; // Replace with the name of your home page file

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // ignore: unused_field
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4093CE),
              Color(0xFF9BCEF3),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60.0),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 50),
                        child: const LoadingLogo(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
