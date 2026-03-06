// ignore_for_file: prefer_match_file_name
import 'package:color_generator/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// The main entry point for the Color Generator application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Generator',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
