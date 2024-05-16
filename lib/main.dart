import 'package:flutter/material.dart';
import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/pages/start_screen.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Tips App'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: StartScreen(employees: mockEmployees,),
    ),
  ));
}
