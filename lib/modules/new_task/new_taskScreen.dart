import 'package:flutter/material.dart';
import 'package:todoapp/core/network/local/sql_server.dart';

import '../../models/task_model.dart';
import '../../widget/taskItem.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemBuilder: (context, index) {
              TaskModel model = SqlServices.tasks[index];
              return Taskitem(model);
            },
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Divider(),
            ),
            itemCount: SqlServices.tasks.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: SqlServices().getDate(),
    );
  }
}
