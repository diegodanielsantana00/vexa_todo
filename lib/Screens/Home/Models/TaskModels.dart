// ignore_for_file: non_constant_identifier_names, file_names

import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/AddTask/Models/Tags.dart';
import 'package:vexa_todo/Screens/AddTask/Models/TaskTags.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';

class TaskModels {
  Future<List<Task>> GetTask(bool allBool, DateTime dateAux) async {
    List<Task> resultAux = await DatabaseHelper().getTask();
    List<Task> resultTask = [];
    for (var element in resultAux) {
      element.types = await DatabaseHelper().getTaskType(id_task: element.id);

      element.tags = await getTags(element.id??0);

      if (allBool) {
        resultTask.add(element);
      } else {
        DateTime dateProgrammedCovert = StringISO0081toDateTime(element.date_programmed ?? "");
        if (validateDateEqualDayMothYears(dateProgrammedCovert, dateAux)) {
          resultTask.add(element);
        }
      }
    }

    resultTask = OrderList(resultTask);

    return resultTask;
  }

  List<Task> OrderList(List<Task> list) {
    list.sort((a, b) {
      return a.finish!.compareTo(b.finish ?? "N");
    });

    list.sort((a, b) {
      return StringISO0081toDateTime(b.date_programmed ?? "").compareTo(StringISO0081toDateTime(a.date_programmed ?? ""));
    });

    return list;
  }

  Future<List<Tags>> getTags(int id_task) async {
    List<TaskTags> tagsAux = await DatabaseHelper().getTaskTags(id_task: id_task);
    List<Tags> tags = [];
    for (var element in resultAuxTagsAll) {
      if (tagsAux.map((e) => e.id_tag).toList().contains(element.id)) {
        tags.add(element);
      }
    }

    return tags;
  }
}
