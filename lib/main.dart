import 'package:flutter/material.dart';
import 'package:flutter_bloc_cart/screens/home/ui/home_page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Rubik'),
      home: HomePage(),
    );
  }
}
