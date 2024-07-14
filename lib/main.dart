import 'package:api_tutorial/complex_example.dart';
import 'package:api_tutorial/example_three.dart';
import 'package:api_tutorial/example_two.dart';
import 'package:api_tutorial/home_screen.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ComplexExample(),
    );
  }
}
