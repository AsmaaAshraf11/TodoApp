import 'package:flutter/material.dart';

class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("done Tasks",
      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
    );
  }
}