// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';
import 'package:vexa_todo/Screens/Home/Models/Type.dart';
import 'package:vexa_todo/Screens/Home/Widget/AddTaskScreenWidgets.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  AddTaskWidget widgetsScreen = AddTaskWidget();

  List<TypeTask> listType = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Nova Tarefa", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700)),
          ],
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context, false);
                //NavigatorController().navigatorBack(context);
              },
              icon: Icon(Icons.cancel),
              color: Colors.red)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              widgetsScreen.TitleTextField(context, titleEditingController),
              widgetsScreen.ColorsWidgets(context),
              widgetsScreen.PhasesWidgets(context, listType),
              widgetsScreen.TextAreaDescription(context, descriptionEditingController),
              SizedBox(
                height: 10,
              ),
              widgetsScreen.DateTimeTextField(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                color: Colors.green,
                onPressed: () async {
                  //DatabaseHelper().executeStringLocal("DELETE FROM task;");
                  //DatabaseHelper().executeStringLocal("DELETE FROM task_type;");
                  int id_task = await DatabaseHelper().insertDatabase(
                      "task",
                      Task(
                          title: titleEditingController.text,
                          text: descriptionEditingController.text,
                          color: widgetsScreen.colorString,
                          notifications: widgetsScreen.selectNotification.toIso8601String()));
                  for (var element in listType) {
                    element.id_task = id_task;
                    element.check_task = "N";
                    DatabaseHelper().insertDatabase("task_type", element);
                  }
                  //DatabaseHelper().getTask();
                  //DatabaseHelper().getTaskType();

                  Navigator.pop(context, true);
                },
                child: Text("Adicionar", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
          )),
    );
  }
}
