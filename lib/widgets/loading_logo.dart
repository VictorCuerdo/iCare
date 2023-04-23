import 'package:flutter/material.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png', // Replace with your own logo image path
            height: 350,
            width: 350,
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(), // Add a circular loading indicator
        ],
      ),
    );
  }
}
