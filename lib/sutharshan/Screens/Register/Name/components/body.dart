import 'package:wo_skills/sutharshan/Screens/Register/Dob/dob_screen.dart';
import 'package:wo_skills/sutharshan/components/rounded_button.dart';
import 'package:wo_skills/sutharshan/components/rounded_input_field.dart';
import 'package:flutter/material.dart';

import 'background.dart';

class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "What's your name?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Enter the name you use in real life.",
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "First Name",
            ),
            RoundedInputField(
              hintText: "Last Name",
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Next",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DobScreen();
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
