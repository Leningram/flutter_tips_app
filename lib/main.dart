import 'package:flutter/material.dart';
import 'package:flutter_tips_app/constants/mock.dart';
import 'package:flutter_tips_app/presentations/pages/start_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 42, 101, 183));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 45, 54, 46));

void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
      cardTheme: CardTheme(
        color: kDarkColorScheme.secondaryContainer,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDarkColorScheme.onSecondaryContainer,
            fontSize: 14,
          )),
    ),
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color.fromARGB(255, 42, 101, 183),
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: kColorScheme.secondaryContainer,
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 14,
            ),
          ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Tips App'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: StartScreen(
        employees: mockEmployees,
      ),
    ),
  ));
}
