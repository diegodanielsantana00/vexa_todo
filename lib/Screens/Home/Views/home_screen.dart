// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Controller/AdsController.dart';
import 'package:vexa_todo/Screens/AddTask/Views/add_task_screen.dart';
import 'package:vexa_todo/Screens/Home/Widget/HomeScreenWidgets.dart';

bool boolAllTask = false;

class HomeScreen extends StatefulWidget {
  AdsController adsController;
  HomeScreen(this.adsController, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectDate = DateTime.now();
  HomeScreenWidgets widgetsScreen = HomeScreenWidgets();

  @override
  void initState() {
    super.initState();
    // widget.adsController.ativarAds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            boolAllTask
                ? Text("Todas tarefas", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700))
                : GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          theme: DatePickerTheme(
                              headerColor: Colors.white,
                              backgroundColor: Colors.white,
                              itemStyle: TextStyle(color: Colors.black, fontSize: 18),
                              doneStyle: TextStyle(color: Colors.green, fontSize: 16)), onConfirm: (date) {
                        selectDate = date;
                        RestartScreenHotRestart(context);
                      }, currentTime: selectDate, locale: LocaleType.pt);
                    },
                    child: Row(
                      children: [
                        Text((selectDate.day == DateTime.now().day && selectDate.month == DateTime.now().month && selectDate.year == DateTime.now().year) ? "HOJE  " : "${selectDate.year.toString()} ",
                            style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700)),
                        Text("${selectDate.day} ${GetNameMonth(selectDate.month)}", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
          ],
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                boolAllTask = boolAllTask ? false : true;
                setState(() {});
              },
              icon: Icon(boolAllTask ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
              color: Colors.black),
          IconButton(
              onPressed: () async {
                bool result = await NavigatorController().navigatorToReturn(context, AddTaskScreen());
                if (result) {
                  widget.adsController.startAds = true;
                  widget.adsController.mostrarAds();
                  RestartScreenHotRestart(context);
                }
              },
              icon: Icon(Icons.add),
              color: Colors.black)
        ],
      ),
      body: Column(
        children: [Divider(), Expanded(child: widgetsScreen.ListTaskViews(boolAllTask, selectDate, context))],
      ),
    );
  }
}
