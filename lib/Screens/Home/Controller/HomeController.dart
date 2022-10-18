import 'package:intl/intl.dart';

class HomeController {
  String NumberTypeinTask(int number) {
    if (number == 0) return "";
    return number == 1 ? " • 1 Tarefa" : " • $number Tarefas";
  }

  String ReturnDateProgramed(String dateString) {
    final DateFormat formatter = DateFormat('Hm');
    DateTime date = DateTime.parse(dateString);

    return formatter.format(date);
  }
}
