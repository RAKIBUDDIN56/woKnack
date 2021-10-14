import 'dart:io';

import 'package:wo_skills/sutharshan/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

class PictureFace extends StatefulWidget {
  @override
  _PictureFaceState createState() => _PictureFaceState();
}

class _PictureFaceState extends State<PictureFace> {
  File _imageFile;

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Image to Firebase Storage",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
// uploading image from the camera UI design
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: double.infinity,
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 100.0),
                          child: FlatButton(
                            color: Colors.blue[100],
                            child: Text('Pick from Camera'),
                            onPressed: () => pickImage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30.0)),
            child: RoundedButton(),
          ),
        ],
      ),
    );
  }
}
