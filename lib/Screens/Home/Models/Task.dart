// ignore_for_file: non_constant_identifier_names, file_names

class Task {
  Task({this.id, this.text, this.color, this.priority, this.date_create, this.date_programmed, this.notifications, this.type, this.tags});

  int? id;
  String? text;
  String? color;
  int? priority;
  DateTime? date_create;
  DateTime? date_programmed;
  List<DateTime>? notifications;
  List<String>? type;
  List<int>? tags;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id, 
      'text': text, 
      'color': color, 
      'priority': priority, 
      'date_create': date_create, 
      'date_programmed': date_programmed, 
      'type': type, 
      'tags': tags, 
      'notifications': notifications};
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    text = map['text'];
    color = map['color'];
    priority = map['priority'];
    date_create = map['date_create'];
    date_programmed = map['date_programmed'];
    type = map['type'];
    tags = map['tags'];
    notifications = map['notifications'];
  }
}
