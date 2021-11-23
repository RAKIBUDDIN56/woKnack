import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wo_skills/pages/home_page.dart';
import 'package:wo_skills/pages/home_screen.dart';
import 'package:wo_skills/signup/registration_screen.dart';
import 'package:wo_skills/sutharshan/Screens/Register/Gender/components/body.dart';
import 'package:wo_skills/sutharshan/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:wo_skills/tabs/gender.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      title: 'wo_skills',
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? MyHomePage.idScreen
          : RegisterScreen.idScreen,
      routes: {
        MyHomePage.idScreen: (context) => MyHomePage(),
        RegisterScreen.idScreen: (context) => RegisterScreen()
      },
    );
  }
}
