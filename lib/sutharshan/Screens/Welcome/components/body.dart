import 'package:wo_skills/sutharshan/components/already_have_an_account_acheck.dart';
import 'package:flutter/material.dart';
import 'package:wo_skills/sutharshan/Screens/Login/login_screen.dart';
import 'package:wo_skills/sutharshan/Screens/Register/Name/name_screen.dart';
import 'package:wo_skills/sutharshan/Screens/Welcome/components/background.dart';
import 'package:wo_skills/sutharshan/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO WoSkills",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "Join WoSkills - The professional social media application for women",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "We'll help you to create a new account in a few easy steps",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            RoundedButton(
              text: "Get Started",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NameScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.05),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
