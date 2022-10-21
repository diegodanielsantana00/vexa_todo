// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, invalid_use_of_protected_member, file_names

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vexa_todo/Common/GlobalFunctions.dart';
import 'package:vexa_todo/Screens/Home/Models/Type.dart';

bool selectColor = false;
bool selectAddType = false;
Color selectColorOption = Colors.white;

class AddTaskWidget {
  String colorString = Colors.white.toString();
  DateTime selectNotification = DateTime.now();
  DateTime selectNotificationPro = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  bool boolSelectNotification = false;
  bool boolPriority = false;

  Widget PhasesWidgets(BuildContext context, List<TypeTask> listType) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (int i = 0; i < listType.length; i++)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.menu, color: Colors.grey),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  SizedBox(
                    width: 170,
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      onChanged: (value) {
                        listType[i].title = value;
                      },
                      cursorColor: const Color.fromARGB(255, 85, 58, 1),
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                      ),
                      autofocus: listType[i].title == null || listType[i].title == "",
                    ),
                  ),
                ],
              ),
            AddType(context, listType),
            Divider()
          ],
        ));
  }

  Widget AddType(BuildContext context, List<TypeTask> listType) {
    return GestureDetector(
      onTap: () {
        listType.add(TypeTask());
        RestartScreenHotRestart(context);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add, color: Colors.grey),
          ),
          Text("Adicionar etapa")
        ],
      ),
    );
  }

  Widget TitleTextField(BuildContext context, TextEditingController titleEditingController) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectColor = selectColor ? false : true;
            (context as Element).reassemble();
          },
          child: CircleAvatar(
            radius: 14,
            backgroundColor: selectColorOption == Colors.white ? Colors.grey : selectColorOption,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: selectColorOption,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 170,
            child: TextFormField(
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
              keyboardType: TextInputType.name,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              cursorColor: const Color.fromARGB(255, 85, 58, 1),
              decoration: InputDecoration(
                hintText: "Sem título",
                border: InputBorder.none,
              ),
              controller: titleEditingController,
              autofocus: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget StarPriority(BuildContext context) {
    if (boolPriority) {
      return GestureDetector(
        onTap: () {
          boolPriority = boolPriority ? false : true;
          RestartScreenHotRestart(context);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Icon(Icons.star, color: Colors.amber),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          boolPriority = boolPriority ? false : true;
          RestartScreenHotRestart(context);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Icon(Icons.star, color: Colors.grey),
        ),
      );
    }
  }

  Widget ColorsWidgets(BuildContext context) {
    if (selectColor) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularColor(context, Colors.red[300]),
          CircularColor(context, Colors.orange[300]),
          CircularColor(context, Colors.green[300]),
          CircularColor(context, Colors.black),
          CircularColor(context, Colors.white),
          CircularColor(context, Colors.blue[300]),
          CircularColor(context, Colors.brown[300]),
          CircularColor(context, Colors.deepPurpleAccent),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget DateTimeTextField(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now().add(Duration(days: 1)),
                  maxTime: DateTime.now().add(Duration(days: 6000)),
                  theme: DatePickerTheme(
                      headerColor: Colors.white,
                      backgroundColor: Colors.white,
                      itemStyle: TextStyle(color: Colors.black, fontSize: 18),
                      doneStyle: TextStyle(color: Colors.green, fontSize: 16)), onConfirm: (date) {
                selectNotification = date;
                boolSelectNotification = true;
                (context as Element).reassemble();
              }, currentTime: selectNotification, locale: LocaleType.pt);
            },
            icon: Icon(
              Icons.notification_add,
              color: boolSelectNotification ? Colors.green[800] : Colors.black,
            ))
      ],
    );
  }

  Widget DateTimeProTextField(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: DateTime.now().add(Duration(hours: 1)),
            theme: DatePickerTheme(
                headerColor: Colors.white,
                backgroundColor: Colors.white,
                itemStyle: TextStyle(color: Colors.black, fontSize: 18),
                doneStyle: TextStyle(color: Colors.green, fontSize: 16)), onConfirm: (date) {
          selectNotificationPro = date;
          (context as Element).reassemble();
        }, currentTime: selectNotificationPro, locale: LocaleType.pt);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.restore_outlined),
            ),
            Text(validateDateEqualDayMothYears(selectNotificationPro, DateTime.now()) ? "Hoje" : formatter.format(selectNotificationPro))
          ],
        ),
      ),
    );
  }

  Widget TextAreaDescription(BuildContext context, TextEditingController descriptionEditingController) {
    return Card(
        color: Colors.grey[50],
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            maxLines: 4,
            decoration: InputDecoration.collapsed(hintText: "Descrição"),
            controller: descriptionEditingController,
          ),
        ));
  }

  Widget CircularColor(BuildContext context, Color? color) {
    return GestureDetector(
      onTap: () {
        selectColorOption = color!;
        colorString = color.toString();
        selectColor = false;
        (context as Element).reassemble();
      },
      child: CircleAvatar(
        radius: 13,
        backgroundColor: color,
      ),
    );
  }
}
