// ignore_for_file: non_constant_identifier_names, file_names

import 'package:vexa_todo/Screens/Home/Models/Type.dart';

class Task {
  Task({this.id, this.text, this.title, this.color, this.priority, this.date_create, this.date_programmed, this.notifications, this.finish});

  int? id;
  String? text;
  String? title;
  String? color;
  String? finish;
  int? priority;
  String? date_create;
  String? date_programmed;
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
      'notifications': notifications,
      'finish': finish
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
    finish = map['finish'];
  }
}
