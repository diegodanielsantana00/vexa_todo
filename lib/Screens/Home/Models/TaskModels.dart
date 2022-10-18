import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';

class TaskModels {
  Future<List<Task>> GetTask() async {
    List<Task> result = await DatabaseHelper().getTask();
    for (var element in result) {
      element.types = await DatabaseHelper().getTaskType(id_task: element.id);
    }

    return result;
  }
}
