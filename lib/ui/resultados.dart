<<<<<<< Updated upstream
=======
// ignore_for_file: library_private_types_in_public_api
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icare/ui/lobby.dart';

class Resultados extends StatefulWidget {
  const Resultados({Key? key}) : super(key: key);

  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
<<<<<<< Updated upstream
=======
  late Map<String, dynamic> result;

  @override
  void initState() {
    super.initState();
    result = Get.arguments as Map<String, dynamic>;
  }

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
<<<<<<< Updated upstream
                children: const <Widget>[
                  SizedBox(
                      height:
                          80.0), // Increase the space to avoid overlap with the icons
=======
                children: <Widget>[
                  const SizedBox(
                      height:
                          80.0), // Increase the space to avoid overlap with the icons
                  ...result.entries
                      .map((entry) => Text('${entry.key}: ${entry.value}'))
                      .toList(),
>>>>>>> Stashed changes
                  // Other widgets go here...
                ],
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: () {
                      // TODO: implement onPressed
                    },
                    icon: const Icon(Icons.print_outlined, size: 40),
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      Get.off(() => Lobby());
                    },
                    icon: const Icon(Icons.widgets_outlined, size: 40),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
