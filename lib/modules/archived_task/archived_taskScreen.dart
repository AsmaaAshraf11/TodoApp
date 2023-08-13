import 'package:flutter/material.dart';

class ArchivedTaskScreen extends StatelessWidget {
  const ArchivedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("archived Tasks",
      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
    );
  }
}