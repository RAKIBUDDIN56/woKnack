import 'package:wo_skills/sutharshan/Screens/Register/Email/email_screen.dart';
import 'package:wo_skills/sutharshan/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';

import '../../Name/components/background.dart';

class DOB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "What's your date of birth?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Choose your date of birth. You can always make this private later.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DatePickerWidget(
                looping: false,
                lastDate: DateTime.now(),
                dateFormat: "dd-MMMM-yyyy",
                onChange: (DateTime newDate, _) {
                  _selectedDate = newDate;
                  print(_selectedDate);
                },
                pickerTheme: DateTimePickerTheme(
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: Colors.blue,
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
                      return EmailScreen();
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
