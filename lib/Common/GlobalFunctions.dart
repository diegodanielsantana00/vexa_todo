// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vexa_todo/Screens/AddTask/Models/Tags.dart';
import 'package:yaml/yaml.dart';

List<Tags> resultAuxTagsAll = [ // Temporary
        Tags(id: 98273170, title: "Trabalho", color: Colors.blue[300].toString()),
        Tags(id: 98273171, title: "Estudos", color: Colors.pink[300].toString()),
        Tags(id: 98273172, title: "Pets", color: Colors.green.toString()),
        Tags(id: 98273173, title: "Casa", color: Colors.red.toString()),
        Tags(id: 98273174, title: "Outros", color: Colors.lime.toString())
      ];

String GetNameMonth(int month) {
  List months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
  return months[month - 1];
}

ButtonStyle styleButtonDefaut(Color color) {
  return TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: color,
    padding: EdgeInsets.all(0),
  );
}

DateTime StringISO0081toDateTime(String dateString) {
  return DateTime.parse(dateString);
}

Color StringToColor(String colorString) {
  String valueString = colorString.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);
  ;
}

bool validateDateEqualDayMothYears(
  DateTime dateOne,
  DateTime dateTwo,
) {
  return dateOne.day == dateTwo.day && dateOne.month == dateTwo.month && dateOne.year == dateTwo.year;
}

void RestartScreenHotRestart(BuildContext context) {
  (context as Element).reassemble();
}

Future<String> GetVersion() async {
  var file = await rootBundle.loadString("pubspec.yaml");
  var yaml = loadYaml(file);
  return yaml["version"];
}
