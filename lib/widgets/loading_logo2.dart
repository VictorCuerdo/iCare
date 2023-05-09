import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingLogo2 extends StatelessWidget {
  const LoadingLogo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30.0),
          Lottie.asset(
            'assets/images/loading.json',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
