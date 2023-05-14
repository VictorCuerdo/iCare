import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'i',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'RobotoSlab',
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'CARE',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'RobotoSlab',
                    color: Color.fromARGB(255, 18, 2, 91),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Lottie.asset(
            'assets/images/vacine.json',
            width: 250,
            height: 250,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 70),
          const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueGrey)), // Add a circular loading indicator
        ],
      ),
    );
  }
}
