import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../layout/hom_layout.dart';
import '../../widget/taskItem.dart';


class NewTaskScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index)=>Taskitem(tasks[index]),
       separatorBuilder: (context,index)=>Container(

        width: double.infinity,
        height: 2,
        color: Colors.grey[300],
       ) ,
       itemCount: tasks.length);
  }
}