import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/Home/Controller/HomeController.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';

class TaskModels {
  Future<List<Task>> GetTask(bool allBool, DateTime dateAux) async {
    List<Task> resultAux = await DatabaseHelper().getTask();
    List<Task> resultTask = [];
    for (var element in resultAux) {
      element.types = await DatabaseHelper().getTaskType(id_task: element.id);
      if (allBool) {
        resultTask.add(element);
      } else {
        DateTime dateProgrammedCovert = StringISO0081toDateTime(element.date_programmed ?? "");
        if (validateDateEqualDayMothYears(dateProgrammedCovert, dateAux)) {
          resultTask.add(element);
        }
      }
    }

    return resultTask;
  }
}
