// ignore_for_file: non_constant_identifier_names, file_names

class TypeTask {
  TypeTask({this.id, this.id_task,this.title, this.check_task});

  int? id;
  int? id_task;
  String? title;
  String? check_task;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'id_task': id_task,
      'title': title,
      'check_task': check_task,
    };
    return map;
  }


  TypeTask.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    id_task = map['id_task'];
    title = map['title'];
    check_task = map['check_task'];
  }
}
