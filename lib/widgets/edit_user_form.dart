import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class FormularioUsuario extends StatefulWidget {
  const FormularioUsuario({Key? key}) : super(key: key);

  @override
  _FormularioUsuarioState createState() => _FormularioUsuarioState();
}

class _FormularioUsuarioState extends State<FormularioUsuario> {
  String? _name;
  String? _lastName;
  String? _email;
  PhoneNumber _telephone = PhoneNumber(isoCode: 'CO');
  String? _sexo;
  double? _height;
  String? _age;
  DateTime? _fechaVacuna;
  final Map<String, bool> _symptoms = {
    "Dolor de cabeza": false,
    "Mareo": false,
    "Vomitos": false,
    "Fiebre": false,
  };
  List<bool> _isSelected = [false, false, false];
  final List<String> _sexOptions = ['Masculino', 'Femenino', 'N/A'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Inserte Nombre(s)'),
            initialValue: _name,
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Inserte Apellido(s)'),
            initialValue: _lastName,
            onChanged: (value) {
              setState(() {
                _lastName = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Inserte Email'),
                  initialValue: _email,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip:
                    'Inserte su correo electrónico en formato xxxx@gmail.com',
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          const Text('Seleccione su sexo:', style: TextStyle(fontSize: 17)),
          const SizedBox(height: 15.0),
          ToggleButtons(
            isSelected: _isSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _isSelected.length; i++) {
                  _isSelected[i] = i == index;
                }
                _sexo = _sexOptions[index];
              });
            },
            borderRadius: BorderRadius.circular(24.0),
            children: _sexOptions.map((option) {
              int index = _sexOptions.indexOf(option);
              Color? backgroundColor;
              //if (_isSelected[index]) {
              //  if (option == 'Masculino') {
              //    backgroundColor = Colors.blue;
              //  } else if (option == 'Femenino') {
              //    backgroundColor = Colors.pink;
              //   }
              //  }
              return Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(option),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          InternationalPhoneNumberInput(
            initialValue: _telephone,
            inputDecoration:
                const InputDecoration(labelText: 'Inserte Numero telefono'),
            onInputChanged: (value) {
              setState(() {
                _telephone = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
          const Text('Seleccione fecha de aplicación de su dosis:',
              style: TextStyle(fontSize: 17)),
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            onDateChanged: (value) {
              setState(() {
                _fechaVacuna = value;
              });
            },
          ),
          const SizedBox(height: 35.0),
          const Text(
            'Seleccione sintomas presentados',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15.0),
          Column(
            children: _symptoms.keys
                .map((symptom) => CheckboxListTile(
                      title: Text(symptom),
                      value: _symptoms[symptom],
                      onChanged: (bool? value) {
                        setState(() {
                          _symptoms[symptom] = value!;
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
