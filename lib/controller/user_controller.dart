import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var vacunaAplicada = ''.obs;
  var dosisSeleccionadas = 0.obs;
  var symptoms = <String>[].obs;
  var results = <String, dynamic>{}.obs;

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

  void updateUserName(String name) {
    userName.value = name;
  }

  void updateLastName(String lastNameUpdate) {
    lastName.value = lastNameUpdate;
  }

  void updateEmail(String emailUpdate) {
    email.value = emailUpdate;
  }

  void updateVacunaAplicada(String vacunaUpdate) {
    vacunaAplicada.value = vacunaUpdate;
  }

  void updateDosisSeleccionadas(int dosisUpdate) {
    dosisSeleccionadas.value = dosisUpdate;
  }

  void updateSymptoms(List<String> symptomsUpdate) {
    symptoms.value = symptomsUpdate;
  }

  void updateResults(Map<String, dynamic> resultsUpdate) {
    results.value = resultsUpdate;
  }

  String interpretResult(String key, List<dynamic> values) {
    return descriptions[key]![values[0]];
  }
}
