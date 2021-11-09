import 'package:wo_skills/pages/home_page.dart';
import 'package:wo_skills/pages/home_screen.dart';
import 'package:wo_skills/sutharshan/Screens/Register/Gender/components/body.dart';
import 'package:wo_skills/sutharshan/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:wo_skills/tabs/gender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return const MaterialApp(
      title: 'wo_skills',
      debugShowCheckedModeBanner: false,
      home: GenderD(),
    );
  }
}
