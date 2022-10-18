// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/Navigator.dart';
import 'package:vexa_todo/Screens/Home/Views/add_task_screen.dart';
import 'package:vexa_todo/Screens/Home/Widget/HomeScreenWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectDate = DateTime.now();
  HomeScreenWidgets widgetsScreen = HomeScreenWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now().add(Duration(hours: -1)),
                    maxTime: DateTime.now().add(Duration(days: 10)),
                    theme: DatePickerTheme(
                        headerColor: Colors.white,
                        backgroundColor: Colors.white,
                        itemStyle: TextStyle(color: Colors.black, fontSize: 18),
                        doneStyle: TextStyle(color: Colors.green, fontSize: 16)), onConfirm: (date) {
                  selectDate = date;
                  // boolSelectNotification = true;
                  (context as Element).reassemble();
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
                bool result = await NavigatorController().navigatorToReturn(context, AddTaskScreen());
                if (result) {
                  setState(() {});
                }
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
