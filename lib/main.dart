import 'package:flutter/material.dart';
import 'package:icare/ui/loading_screen.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iCare',
      home: LoadingScreen(),
    );
  }
}
