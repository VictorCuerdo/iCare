// ignore_for_file: library_private_types_in_public_api

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSexSelected = false;
  bool _isVacunaSelected = false;
  bool _isEdadSelected = false;
  final List<DateTime?> _fechasVacuna = [null, null, null, null];
  String? _edad;
  String? _vacunaAplicada;
  int? _dosisSeleccionadas;
  TextEditingController _vacunaAplicadaController = TextEditingController();

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
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // FIELD 1 - NOMBRE
          TextFormField(
            decoration:
                const InputDecoration(labelText: 'Ingrese su Nombre(s)'),
            initialValue: _name,
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
          const SizedBox(height: 25.0),
          // FIELD 2 - APELLIDOS
          TextFormField(
            decoration:
                const InputDecoration(labelText: 'Ingrese su Apellido(s)'),
            initialValue: _lastName,
            onChanged: (value) {
              setState(() {
                _lastName = value;
              });
            },
          ),
          const SizedBox(height: 25.0),
          // FIELD 3- EMAIL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Ingrese su E-mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
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
                    'Ingrese su correo electrónico en formato xxxx@gmail.com',
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          // FIELD 4 - EDAD
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Ingrese su edad'),
                  initialValue: _edad,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Campo obligatorio*';
                    } else if (int.parse(value) < 1 || int.parse(value) > 100) {
                      return 'Edad debe ser entre 1 y 100';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _edad = value;
                    });
                    _isEdadSelected = true;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: 'Ingrese su edad en digitos. Minimo 1 - Máximo 100',
                iconSize: 20,
                onPressed: () {},
              ),
              if (!_isEdadSelected)
                const Text(
                  '*Campo obligatorio*',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 40.0),
          // FIELD 5 - SEXO
          const Text('Seleccione su sexo:', style: TextStyle(fontSize: 17)),
          const SizedBox(height: 15.0),
          ToggleButtons(
            isSelected: _isSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _isSelected.length; i++) {
                  _isSelected[i] = i == index;
                }
                _isSexSelected = true;
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
          if (!_isSexSelected)
            const Text(
              '*Campo obligatorio*',
              style: TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 25.0),
          // FIELD 6 - CELULAR
          InternationalPhoneNumberInput(
            initialValue: _telephone,
            inputDecoration: const InputDecoration(labelText: 'Número celular'),
            onInputChanged: (value) {
              setState(() {
                _telephone = value;
              });
            },
          ),
          const SizedBox(height: 25.0),
          // FIELD 7 - NOMBRE VACUNA
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
                _isVacunaSelected = true;
                _vacunaAplicadaController.text = selection;
              });
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              _vacunaAplicadaController = textEditingController;
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                    labelText: 'Ingrese nombre de la vacuna aplicada'),
              );
            },
          ),
          if (!_isVacunaSelected)
            const Text(
              '*Campo obligatorio*',
              style: TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 40.0),
          // FIELD 8 - NUMERO DOSIS
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
          const SizedBox(height: 50.0),
          // FIELD 9 - SINTOMAS
          const Text(
            '¿Ha padecido alguno de estos sintomas?',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25.0),
          Flexible(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text(''),
              onChanged: (String? newValue) {
                setState(() {
                  // Add item only if the list has less than 2 items
                  if (_selectedSymptoms.length < 2 &&
                      !_selectedSymptoms.contains(newValue)) {
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
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Máximo 2 sintomas',
            iconSize: 20,
            onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
