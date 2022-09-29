// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Screens/Home/Widget/HomeScreenWidgets.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  HomeScreenWidgets widgetsScreen = HomeScreenWidgets();
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
                NavigatorController().navigatorBack(context);
              },
              icon: Icon(Icons.cancel),
              color: Colors.red)
        ],
      ),
    );
  }
}
