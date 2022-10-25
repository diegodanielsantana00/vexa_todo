// ignore_for_file: non_constant_identifier_names, file_names


class TaskTags {
  TaskTags({this.id, this.id_task, this.id_tag});

  int? id;
  int? id_task;
  int? id_tag;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'id_tag': id_tag,
      'id_task': id_task,
    };
    return map;
  }

  TaskTags.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    id_tag = map['id_tag'];
    id_task = map['id_task'];
  }
}
