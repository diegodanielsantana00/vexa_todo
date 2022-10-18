// ignore_for_file: non_constant_identifier_names, file_names

import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/Home/Models/Type.dart';

class Task {
  Task({this.id, this.text, this.title, this.color, this.priority, this.date_create, this.date_programmed, this.notifications});

  int? id;
  String? text;
  String? title;
  String? color;
  int? priority;
  DateTime? date_create;
  DateTime? date_programmed;
  String? notifications;
  List<TypeTask>? types;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'text': text,
      'title': title,
      'color': color,
      'priority': priority,
      'date_create': date_create,
      'date_programmed': date_programmed,
      'notifications': notifications
    };
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    text = map['text'];
    title = map['title'];
    color = map['color'];
    priority = map['priority'];
    date_create = map['date_create'];
    date_programmed = map['date_programmed'];
    notifications = map['notifications'];
  }
}
