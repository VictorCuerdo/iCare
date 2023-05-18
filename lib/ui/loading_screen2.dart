// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icare/ui/resultados.dart';
import 'package:icare/widgets/loading_logo2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'lobby.dart';

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

  int sintomas(i) {
    if (i == 'COVID-19') {return 1;}
    else if (i == 'Escalofríos') {return 2;}
    else if (i == 'Artralgia') {return 3;}
    else if (i == 'Mareo') {return 4;}
    else if (i == 'Fatiga') {return 5;}
    else if (i == 'Producto caducado administrado') {return 6;}
    else if (i == 'Dolor de cabeza') {return 7;}
    else if (i == 'Astenia') {return 8;}
    else if (i == 'Pirexia') {return 9;}
    else if (i == 'Dolor') {return 10;}
    else if (i == 'Dolor en la extremidad') {return 11;}
    else if (i == 'Eritema en el sitio de inyección') {return 12;}
    else if (i == 'Error en el almacenamiento del producto') {return 13;}
    else if (i == 'Eritema') {return 14;}
    else if (i == 'Sin evento adverso') {return 15;}
    else if (i == 'Náuseas') {return 16;}
    else if (i == 'Erupción') {return 17;}
    else if (i == 'Disnea') {return 18;}
    else if (i == 'Prurito') {return 19;}
    else if (i == 'Análisis de sangre') {return 20;}
    else if (i == 'Dolor en el lugar de la inyección') {return 21;}
    else if (i == 'Tos') {return 22;}
    else if (i == 'SARS-CoV-2 prueba positiva') {return 23;}
    else if (i == 'Prurito en el lugar de la inyección') {return 24;}
    else if (i == 'Mialgia') {return 25;}
    else if (i == 'Sentirse anormal') {return 26;}
    else if (i == 'Prueba SARS-CoV-2') {return 27;}
    else if (i == 'Diarrea') {return 28;}
    else if (i == 'Dolor de espalda') {return 29;}
    else {return 0;}
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (Get.arguments.length == 5) {
      Get.arguments.add(0);
    }
    Get.arguments[4] = sintomas(Get.arguments[4]);
    Get.arguments[5] = sintomas(Get.arguments[5]);
    await sendMSG(Get.arguments);
  }

  Future sendMSG(msg) async {
    var uri = Uri.parse('https://aware-trail-production.up.railway.app/predict');
    var bod =  jsonEncode({
                            "EDAD": msg[0],
                            "SEXO": msg[1],
                            "NUM_DOSIS": msg[2],
                            "VACUNA": msg[3],
                            "SINT1": msg[4],
                            "SINT2": msg[5]
                          });

    try {
      var response = await http.post(uri,body: bod);
      var result = jsonDecode(response.body);
      Get.off(const Resultados(), arguments: result);
    } catch (e) {
      Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: const Text('No se pudo conectar con el servidor'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ));
      Get.off(() => const Lobby());
    }
    

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
