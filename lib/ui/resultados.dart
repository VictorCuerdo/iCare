// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icare/ui/lobby.dart';
import '../controller/print_Controller.dart';
import '../controller/user_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Resultados extends StatefulWidget {
  const Resultados({Key? key}) : super(key: key);

  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  String _username = '';
  final UserController userController = Get.find();
  late Map<String, dynamic> result;
  Map<String, bool> visibility = {};

  // Defined detailText List with the provided texts
  final List<String> detailText = [
    'Este resultado determina si el paciente entra o no en el grupo de personas reportadas por fallecimiento tras la vacuna contra covid-19. Las muertes directamente atribuibles a las vacunas contra el COVID-19 son extremadamente raras. Sin embargo, ha habido algunas muertes que se han asociado con complicaciones o reacciones a las vacunas...Así el modelo de predicción te haya arrojado un resultado positivo, cuida tu cuerpo y revisate periodicamente!',
    'Este resultado determina si el paciente está o no en riesgo de muerte por haber recibido la vacuna contra el covid-19.El modelo de predicción arroja una cifra entre 1 y 0, y un porcentaje de predicción, los cuales serán interpretados para brindarle una respuesta...Así el modelo de predicción te haya arrojado un resultado positivo, cuida tu cuerpo y revisate periodicamente!',
    'Este resultado determina si el paciente está o no en riesgo de ser ingresado a la unidad de cuidados intensivos.Los casos de personas que necesitan cuidados intensivos después de recibir una vacuna contra el COVID-19 son extremadamente raros, y generalmente están asociados con reacciones severas a la vacuna...Así el modelo de predicción te haya arrojado un resultado positivo, cuida tu cuerpo y revisate periodicamente!',
    'Este resultado determina si el paciente está o no en riesgo de ser hospitalizado, o si en su defecto ya lo estuvo...Así el modelo de predicción te haya arrojado un resultado positivo, cuida tu cuerpo y revisate periodicamente!',
    'Este resultado determina si el paciente está o no en riesgo de sufrir una discapacidad como consecuencia de la vacuna administrada...Así el modelo de predicción te haya arrojado un resultado positivo, cuida tu cuerpo y revisate periodicamente!',
  ];

  @override
  void initState() {
    super.initState();
    result = Get.arguments as Map<String, dynamic>;
    userController.updateResults(result);
    if (userController.userName.value.isNotEmpty) {
      _username = userController.userName.value;
    }
    // Initialize visibility.
    result.keys.forEach((key) {
      visibility[key] = false;
    });
  }

  String _interpretResult(String key, List<dynamic> values) {
    final Map<String, List<String>> descriptions = {
      "DIED": ["El paciente no murió", "El paciente murió"],
      "THRE": [
        "El paciente no está en riesgo de Muerte por vacuna",
        "El paciente está en riesgo de muerte por vacuna"
      ],
      "VISI": ["El paciente no estuvo en UCI", "El paciente estuvo en UCI"],
      "HOSP": [
        "El paciente no fue hospitalizado por la vacuna",
        "El paciente fue hospitalizado por la vacuna"
      ],
      "DISA": [
        "El paciente no tiene/tendrá una discapacidad por la vacuna",
        "El paciente tiene/tendrá una discapacidad por la vacuna"
      ]
    };
    return descriptions[key]![values[0]];
  }

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);

    List<Widget> entriesWidgets = [];
    int index = 0;
    for (var entry in result.entries) {
      if (entry.value is List && entry.value.length > 1) {
        entriesWidgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _interpretResult(entry.key, entry.value),
              style: const TextStyle(
                  color: Color.fromRGBO(95, 255, 202, 1),
                  fontFamily: 'Lora',
                  fontSize: 17),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  visibility[entry.key] = !visibility[entry.key]!;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                value: entry.value[1],
                                strokeWidth: 10,
                                backgroundColor: Colors.grey,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(222, 41, 134, 1),
                                ),
                              ),
                            ),
                            Text(
                              '${(entry.value[1] * 100).toStringAsFixed(2)}%',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lora'),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Precisión de los datos",
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Lora',
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Click ver detalles",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Lora',
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            if (visibility[entry.key] ?? false)
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromRGBO(222, 41, 134, 1),
                ),
                child: Center(
                  child: Text(
                    detailText[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Lora',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            const SizedBox(height: 20.0),
          ],
        ));
        index++;
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 20, 50, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  Text(
                    _username,
                    style: GoogleFonts.alfaSlabOne(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ...entriesWidgets,
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
                      printDocument();
                    },
                    icon: const Icon(Icons.print_outlined, size: 40),
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      Get.off(() => const Lobby());
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
