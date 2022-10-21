// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Common/SQLiteHelper.dart';
import 'package:vexa_todo/Screens/Home/Controller/HomeController.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';
import 'package:vexa_todo/Screens/Home/Models/TaskModels.dart';
import 'package:vexa_todo/Screens/Home/Models/Type.dart';

class HomeScreenWidgets {
  Widget ListTaskViews(bool allTask, DateTime todayDate) {
    return FutureBuilder<List<Task>>(
      future: TaskModels().GetTask(allTask, todayDate),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ModalAddTask(context, snapshot.data![index]);
                      },
                      child: Container(
                        height: 70,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text("${snapshot.data![index].title}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                                        ],
                                      ),
                                      Text(
                                          "${HomeController().ReturnHourDateProgramed(snapshot.data![index].date_programmed ?? "2022-10-02")} • Pets${HomeController().NumberTypeinTask(snapshot.data![index].types!.length)}",
                                          style: TextStyle(color: Colors.grey[600]))
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.all(Radius.circular(7))),
                                child: Icon(Icons.star, color: Colors.amber),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    LineTaskComplete(snapshot.data![index].finish ?? "N")
                  ],
                );
              });
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ModalAddTask(BuildContext context, Task task) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(8),
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.title ?? "", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                            Text(
                                "${validateDateEqualDayMothYears(StringISO0081toDateTime(task.date_programmed ?? ""), DateTime.now()) ? "Hoje" : HomeController().ReturnDateProgramed(task.date_programmed ?? "2022-10-02")} • ${HomeController().ReturnHourDateProgramed(task.date_programmed ?? "2022-10-02")}",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        )
                      ],
                    ),
                    SizedBox()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  task.text ?? "",
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.start,
                ),
              ),
              ReturnType(task.types, context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonComplete(task.id ?? 0),
                  ),
                  ButtonDelete(task.id ?? 0),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
            ])));
  }

  Widget ReturnType(List<TypeTask>? types, context) {
    return Column(
      children: [
        for (int i = 0; i < types!.length; i++)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.menu, color: Colors.grey),
              ),
              Checkbox(
                onChanged: (bool? value) {
                  print(value);
                  types[i].check_task = (value ?? false) ? "Y" : "N";
                  DatabaseHelper().updateTypeCheck(types[i].check_task ?? "N", types[i].id ?? 0);
                  (context as Element).reassemble();
                },
                tristate: i == 1,
                value: types[i].check_task == "Y",
                activeColor: Colors.green,
              ),
              Text(types[i].title ?? "")
            ],
          ),
        Divider()
      ],
    );
  }
}

Widget ButtonComplete(int id_task) {
  return Center(
      child: ElevatedButton(
          style: styleButtonDefaut(),
          onPressed: () async {
            // DatabaseHelper().updateTaskComplete(id_task);
          },
          child: Icon(Icons.check),
          ));
}

Widget ButtonDelete(int id_task) {
  return Center(
      child: ElevatedButton(
          style: styleButtonDefautRed(),
          onPressed: () async {
            DatabaseHelper().deleteTask(id_task);
          },
          child: Icon(Icons.delete),
          ));
}



Widget LineTaskComplete(String finish) {
  if (finish == "Y") {
    return Center(
      child: Container(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 2,
              color: Colors.green[700],
            ),
          ],
        ),
      ),
    );
  } else {
    return SizedBox();
  }
}
