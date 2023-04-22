import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iCare'),
      ),
      body: Container(
        color: Colors.tealAccent,
        child: const Center(
          child: Text(
            'Welcome to iCare!',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
