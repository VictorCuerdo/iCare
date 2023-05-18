// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icare/ui/formulario.dart';
import 'package:icare/ui/dashboard.dart';
import 'package:icare/ui/resultados.dart';
import 'package:icare/widgets/loading_logo2.dart';
import 'package:get/get.dart';

class LoadingScreen2 extends StatefulWidget {
  const LoadingScreen2({Key? key}) : super(key: key);

  @override
  _LoadingScreenState2 createState() => _LoadingScreenState2();
}

class _LoadingScreenState2 extends State<LoadingScreen2> {
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
        builder: (context) => const Resultados(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: const LoadingLogo2(),
          ),
        ],
      ),
    );
  }
}
