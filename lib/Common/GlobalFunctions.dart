// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

String GetNameMonth(int month) {
  List months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
  return months[month - 1];
}

ButtonStyle styleButtonDefaut() {
  return TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Colors.green,
    padding: EdgeInsets.all(0),
  );
}
ButtonStyle styleButtonDefautRed() {
  return TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Colors.red,
    padding: EdgeInsets.all(0),
  );
}

DateTime StringISO0081toDateTime(String dateString) {
  return DateTime.parse(dateString);
}


Color StringToColor(String colorString) {
  String valueString = colorString.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return Color(value);;
}

bool validateDateEqualDayMothYears(DateTime dateOne, DateTime dateTwo,) {
  return dateOne.day == dateTwo.day && dateOne.month == dateTwo.month  && dateOne.year == dateTwo.year;
}

void RestartScreenHotRestart(BuildContext context) {
    (context as Element).reassemble();
}
