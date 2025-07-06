import 'package:flutter/material.dart';
import 'package:todoapp/core/network/local/sql_server.dart';

import 'layout/hom_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlServices().initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomLayout(),
    );
  }
}
