import 'package:flutter/material.dart';
import 'package:icare/ui/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCare',
      home: LoadingScreen(),
    );
  }
}
