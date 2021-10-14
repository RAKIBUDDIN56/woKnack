import 'package:wo_skills/sutharshan/Screens/Register/Picture/picture_screen.dart';
import 'package:wo_skills/sutharshan/components/rounded_button.dart';
import 'package:wo_skills/sutharshan/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../Name/components/background.dart';

class Gender extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const Gender({
    Key key,
    this.hintText,
    this.icon = Icons.person,
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
              "What's your Gender",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Choose your gender from the dropdown below.",
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
                  hintText: "Gender",
                  suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      color: kPrimaryColor,
                      onPressed: () {}),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "There are few more steps to go to verify your gender.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            RoundedButton(
              text: "Next",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PictureScreen();
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
