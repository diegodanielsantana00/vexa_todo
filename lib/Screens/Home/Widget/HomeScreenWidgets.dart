// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:vexa_todo/Screens/Home/Controller/HomeController.dart';
import 'package:vexa_todo/Screens/Home/Models/Task.dart';
import 'package:vexa_todo/Screens/Home/Models/TaskModels.dart';
import 'package:vexa_todo/Screens/Home/Models/Type.dart';

class HomeScreenWidgets {
  Widget ListTaskViews() {
    return FutureBuilder<List<Task>>(
      future: TaskModels().GetTask(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    ModalAddTask(context, snapshot.data![index].types);
                  },
                  child: Container(
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
                                children: [
                                  Text("${snapshot.data![index].title}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                                  Text("14:07 • Pets${HomeController().NumberTypeinTask(snapshot.data![index].types!.length)}", style: TextStyle(color: Colors.grey[600]))
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
            // Estamos procurando pedidos
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

  ModalAddTask(BuildContext context, List<TypeTask>? types) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                width: 60,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.all(Radius.circular(20))),
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
                            Text("Andar com o cachorro", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)), 
                            Text("20:00 • Hoje", style: TextStyle(color: Colors.grey[600]))],
                        )
                      ],
                    ),
                    SizedBox()
                  ],
                ),
              ),
              Text("Andar com cachorro e aproveitar comprar o pão na padaria do lado", style: TextStyle(color: Colors.grey[600])),
              ReturnType(types),

              // Divider(),
              //Text("Andar com cachorro e aproveitar comprar o pão na padaria do lado", style: TextStyle(color: Colors.grey[600])),

              const SizedBox(
                height: 70,
              ),
            ])));
  }

  Widget ReturnType(List<TypeTask>? types) {
    return Column(
      children: [
        for (int i = 0; i < types!.length; i++)
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
              Text(types[i].title ?? "")
            ],
          ),
        Divider()
      ],
    );
  }
}
