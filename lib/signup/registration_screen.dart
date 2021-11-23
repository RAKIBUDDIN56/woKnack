import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wo_skills/tabs/test.dart';

//here
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);
  static const String idScreen = 'registration';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime birthday = DateTime.now();

  final TextEditingController phoneCtrl = TextEditingController(),
      nameCtrl = TextEditingController(),
      emailCtrl = TextEditingController(),
      passwordCtrl = TextEditingController(),
      confirmPasswordCtrl = TextEditingController();

  /// Display error message in scaffold
  void _displayError(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  static Future<void> createUser(String email, String password, String phone,
      String name, DateTime birthday) async {
    var userData = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    ////change
    var doc = _store.collection('woknack_users').doc(userData.user.uid);

    await doc.set({
      'name': name,
      'birthday': birthday,
      'email': email,
      'phone': phone,
    });
  }

  /// Create input fields
  Widget _createInputFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _RegisterTextBox(
            validator: (value) {
              if (int.tryParse(value) == null)
                return "Phone number is not valid";
              else
                return null;
            },
            controller: phoneCtrl,
            hintText: "Phone",
            icon: Icons.phone,
            inputType: TextInputType.phone,
            lengthLimitingTextInputFormatter: [
              LengthLimitingTextInputFormatter(10)
            ],
          ),

          //* name
          _RegisterTextBox(
            controller: nameCtrl,
            hintText: "Name",
            icon: Icons.person,
          ),

          //*email
          _RegisterTextBox(
            validator: (value) {
              return EmailValidator.validate(value) == false
                  ? "Please enter a valid email address"
                  : null;
            },
            controller: emailCtrl,
            hintText: "Email",
            icon: Icons.email,
            inputType: TextInputType.emailAddress,
          ),

          //*Birthday
          _birthDayWidget(),

          //*password
          _RegisterTextBox(
            controller: passwordCtrl,
            hintText: "Password",
            icon: Icons.lock,
            isPassword: true,
          ),

          //*password
          _RegisterTextBox(
            validator: (value) {
              if (passwordCtrl.text != confirmPasswordCtrl.text) {
                return "Two passwords do not match";
              } else if (passwordCtrl.text.length < 6 &&
                  confirmPasswordCtrl.text.length < 6)
                return "Password must be at least 6 digits";
              else
                return null;
            },
            controller: confirmPasswordCtrl,
            hintText: "Confirm Password",
            icon: Icons.lock,
            isPassword: true,
          ),
        ],
      ),
    );
  }

  /// Handle register button click
  void _handleRegisterClick(BuildContext context) async {
    //validate form
    if (!_formKey.currentState.validate()) return;

    try {
      // create user
      await createUser(emailCtrl.text, passwordCtrl.text, phoneCtrl.text,
          nameCtrl.text, birthday);

      // go to home
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        _displayError(context, "This email address is taken");
      } else if (e.code == "weak-password") {
        _displayError(context, "Please use a strong password");
      }
    }
  }

  ///birthday widget

  Widget _birthDayWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DatePickerWidget(
        looping: false,
        lastDate: DateTime.now(),
        dateFormat: 'dd-MMMM-yyyy',
        onChange: (DateTime newDate, _) {
          birthday = newDate;
          print(birthday);
        },
        pickerTheme: DateTimePickerTheme(
          backgroundColor: Colors.white,
          itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
          dividerColor: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 5, right: 5),
          children: [
            //*user image
            SizedBox(height: height * .05),
            Image.asset(
              'assets/images/home_logo.png',
              color: Colors.red[900],
              fit: BoxFit.contain,
            ),

            //*phone number
            _createInputFields(),

            SizedBox(
              width: 100,
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 20,
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => _handleRegisterClick(context),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text('Register', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ),

            //* terms and conditions
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  'By registration in, you agree to the terms and conditions',
                ),
              ),
            ),

            //*Register button

            //* sign in
            // Padding(
            //   padding: const EdgeInsets.only(top: 40.0, bottom: 20),
            //   child: FlatButton(
            //     child: Text("Already have an account? Sign in here"),
            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     onPressed: () {
            //       //go to register screen
            //       Navigator.of(context).pushAndRemoveUntil(
            //         MaterialPageRoute(
            //           builder: (context) => LoginScreen(),
            //         ),
            //         (_) => false,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

/// Register text box
class _RegisterTextBox extends StatelessWidget {
  const _RegisterTextBox(
      {Key key,
      @required this.controller,
      @required this.icon,
      @required this.hintText,
      this.isPassword = false,
      this.inputType = TextInputType.text,
      this.validator,
      this.lengthLimitingTextInputFormatter})
      : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextInputType inputType;
  final FormFieldValidator validator;
  final List<TextInputFormatter> lengthLimitingTextInputFormatter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        width: 348,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Icon(icon),
              ),
            ),
            VerticalDivider(
              color: Colors.white,
              thickness: 2,
              indent: 4,
              endIndent: 4,
            ),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  // invalidate if input is empty
                  if (value.isEmpty) return "This cannot be empty";
                  // Return null if a custom validator is not provided
                  return validator == null ? null : validator(value);
                },
                keyboardType: inputType,
                obscureText: isPassword,
                controller: controller,
                inputFormatters: lengthLimitingTextInputFormatter,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Register screen label
class _RegisterLabel extends StatelessWidget {
  const _RegisterLabel({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Icon(icon),
              ),
            ),
            VerticalDivider(
              color: Colors.white,
              thickness: 2,
              indent: 4,
              endIndent: 4,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.black),
                // decoration: InputDecoration(border: InputBorder.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}
