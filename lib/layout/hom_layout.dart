import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/network/local/sql_server.dart';
import 'package:todoapp/modules/archived_task/archived_taskScreen.dart';

import '../modules/don_task/don_taskScreen.dart';
import '../modules/new_task/new_taskScreen.dart';

class HomLayout extends StatefulWidget {
  const HomLayout({super.key});

  @override
  State<HomLayout> createState() => _HomLayoutState();
}

class _HomLayoutState extends State<HomLayout> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchivedTaskScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  bool bottomSheetShow = false;
  IconData fadicon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(titles[currentIndex])
          //Text("Todo App"),
          ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (bottomSheetShow) {
            Navigator.pop(context);
            bottomSheetShow = false;
            setState(() {
              fadicon = Icons.edit;
            });
          } else {
            scaffoldKey.currentState!.showBottomSheet(
              (context) {
                return Form(
                  key: formKey,
                  child: Container(
                    //color: const Color.fromARGB(125, 255, 255, 255),
                    //color: Colors.grey[300],
                    margin: const EdgeInsets.all(20),
                    //padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "title not be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Task Title",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.title)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: timeController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "time not be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Task time",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.watch_later)),
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then(
                              (value) => timeController.text =
                                  value!.format(context).toString(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: dateController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "time not be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Task date",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.watch_later)),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-05-03'))
                                .then((value) => dateController.text =
                                    DateFormat.yMMMd().format(value!));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            color: const Color.fromARGB(255, 76, 144, 175),
                            height: 50,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: const Text(
                              "sav",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SqlServices().insertToDataBas(
                                  title: titleController.text.trim(),
                                  date: dateController.text.trim(),
                                  time: timeController.text.trim(),
                                );
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              elevation: 150,
            );
            bottomSheetShow = true;
            setState(() {
              fadicon = Icons.add;
            });
          }
        },
        child: Icon(fadicon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Done",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Archived",
          ),
        ],
      ),
    );
  }
}
