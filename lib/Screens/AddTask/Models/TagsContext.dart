// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Screens/AddTask/Models/Tags.dart';

class TagsContext {
  Future<List<Tags>> GetTask() async {
    //List<Tags> resultAux = await DatabaseHelper().getTags();
    
    return resultAuxTagsAll;
  }
}
