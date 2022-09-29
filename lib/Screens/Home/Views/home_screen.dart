// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Screens/Home/Views/add_task_screen.dart';
import 'package:vexa_todo/Screens/Home/Widget/HomeScreenWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenWidgets widgetsScreen = HomeScreenWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("HOJE  ", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700)),
            Text("25 Maio", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.grey,
            )
          ],
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                NavigatorController().navigatorToReturn(context, AddTaskScreen());
              },
              icon: Icon(Icons.add),
              color: Colors.black)
        ],
      ),
      body: Column(
        children: [Divider(), Expanded(child: widgetsScreen.ListTaskViews())],
      ),
    );
  }
}
