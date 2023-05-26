import 'package:flutter/material.dart';
import 'package:icare/ui/loading_screen.dart';
import 'package:get/get.dart';

import 'controller/user_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'icare',
      home: LoadingScreen(),
    );
  }
}
