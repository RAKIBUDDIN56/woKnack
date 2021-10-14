import 'package:wo_skills/sutharshan/Screens/Register/Gender/gender_screen.dart';
import 'package:wo_skills/sutharshan/Screens/Register/Mobile/mobile_screen.dart';
import 'package:wo_skills/sutharshan/components/rounded_button.dart';
import 'package:wo_skills/sutharshan/components/rounded_skipButton.dart';
import 'package:wo_skills/sutharshan/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../Name/components/background.dart';

class Email extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const Email({
    Key key,
    this.hintText,
    this.icon = Icons.email,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "What's your Email?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Emter your Email Address. If you don't have an email address by own, You can skip this page.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            TextFieldContainer(
              child: TextField(
                onChanged: onChanged,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    icon,
                    color: kPrimaryColor,
                  ),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Next",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GenderScreen();
                    },
                  ),
                );
              },
            ),
            RoundedSkipButton(
              text: "Skip",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MobileScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
