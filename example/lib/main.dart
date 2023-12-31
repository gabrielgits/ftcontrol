import 'package:flutter/material.dart';
import 'package:ftcontrol/ftcontrol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Error',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: FtcontrolView(
          text: 'Beautiful Error Information',
          //code: 111,
        ),
      ),
    );
  }
}
