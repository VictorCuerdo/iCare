// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icare/ui/lobby.dart';
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
    return Timer(const Duration(seconds: 5), () => Get.off(const Lobby()));
  }

  void onDoneLoading() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Lobby(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60.0),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                      child: const LoadingLogo(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
