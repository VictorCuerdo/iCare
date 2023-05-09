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
  String? _age;
  final List<DateTime?> _fechasVacuna = [null, null, null, null];
  String? _edad;
  String? _vacunaAplicada;
  int? _dosisSeleccionadas;

  final List<String> _autocompleteOptions = [
    'MODERNA',
    'PFIZER-BIONTECH',
    'JANSSEN',
    'PFIZER-BIONTECH BIVALENT',
    'NOVAVAX',
    'MODERNA BIVALENT',
  ];

  final List<String> _symptomsList = [
    'COVID-19',
    'Escalofríos',
    'Artralgia',
    'Mareo',
    'Fatiga',
    'Producto caducado administrado',
    'Dolor de cabeza',
    'Astenia',
    'Pirexia',
    'Dolor',
    'Dolor en la extremidad',
    'Eritema en el sitio de inyección',
    'Error en el almacenamiento del producto',
    'Eritema',
    'Sin evento adverso',
    'Náuseas',
    'Erupción',
    'Disnea',
    'Prurito',
    'Análisis de sangre'
  ];
  final List<String> _selectedSymptoms = [];
  final List<bool> _isSelected = [false, false, false];
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
              });
            },
            borderRadius: BorderRadius.circular(24.0),
            children: _sexOptions.map((option) {
              int index = _sexOptions.indexOf(option);
              Color? backgroundColor;
              /*if (_isSelected[index]) {
              if (option == 'Masculino') {
                  backgroundColor = Colors.blue;
              } else if (option == 'Femenino') {
                  backgroundColor = Colors.pink;
               }
                } */

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
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return _autocompleteOptions.where((String option) {
                return option.contains(textEditingValue.text.toUpperCase());
              });
            },
            onSelected: (String selection) {
              setState(() {
                _vacunaAplicada = selection;
              });
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              textEditingController.text = _vacunaAplicada ?? '';
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                    labelText: 'Ingrese nombre de la vacuna aplicada'),
                onChanged: (value) {
                  setState(() {
                    _vacunaAplicada = value;
                  });
                },
              );
            },
          ),
          const SizedBox(height: 40.0),
          const Text('Seleccione número de dosis aplicadas'),
          DropdownButton<int>(
            value: _dosisSeleccionadas,
            onChanged: (int? newValue) {
              setState(() {
                _dosisSeleccionadas = newValue;
              });
            },
            items: [1, 2, 3, 4]
                .map<DropdownMenuItem<int>>(
                    (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        ))
                .toList(),
          ),
          if (_dosisSeleccionadas != null)
            ...List.generate(_dosisSeleccionadas!, (index) {
              String labelText;
              if (index == 0) {
                labelText = 'Seleccione fecha de aplicación de su dosis';
              } else {
                labelText =
                    'Seleccione fecha de aplicación de su ${index + 1}ª dosis';
              }
              return Column(
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    labelText,
                    style: const TextStyle(fontSize: 17),
                  ),
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    onDateChanged: (value) {
                      setState(() {
                        _fechasVacuna[index] = value;
                      });
                    },
                  ),
                ],
              );
            }),
          const SizedBox(height: 35.0),
          const Text(
            '¿Ha padecido alguno de estos sintomas?',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15.0),
          Flexible(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text(''),
              onChanged: (String? newValue) {
                setState(() {
                  if (!_selectedSymptoms.contains(newValue)) {
                    _selectedSymptoms.add(newValue!);
                  }
                });
              },
              items: _symptomsList
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _selectedSymptoms.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_selectedSymptoms[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _selectedSymptoms.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
