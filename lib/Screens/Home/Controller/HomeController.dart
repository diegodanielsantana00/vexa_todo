// ignore_for_file: non_constant_identifier_names, file_names

import 'package:intl/intl.dart';
import 'package:vexa_todo/Screens/AddTask/Models/Tags.dart';
import 'package:vexa_todo/Screens/AddTask/Models/TaskTags.dart';

class HomeController {
  String NumberTypeinTask(int number) {
    if (number == 0) return "";
    return number == 1 ? " • 1 Tarefa" : " • $number Tarefas";
  }

  String ReturnHourDateProgramed(String dateString) {
    final DateFormat formatter = DateFormat('Hm');
    DateTime date = DateTime.parse(dateString);

    return formatter.format(date);
  }

  String ReturnDateProgramed(String dateString) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime date = DateTime.parse(dateString);

    return formatter.format(date);
  }

  String TaskTagsReturn(List<Tags> tags) {
    String result = "";
    for (var element in tags) {
      result += " • ${element.title ?? ""}";
    }
    return result;
  }
}
