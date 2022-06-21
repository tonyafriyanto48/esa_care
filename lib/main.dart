import 'package:flutter/material.dart';
import 'package:esa_care_fix/screen/welcome.dart';

void main() {
  runApp(Esacare());
}

// ignore: use_key_in_widget_constructors
class Esacare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}