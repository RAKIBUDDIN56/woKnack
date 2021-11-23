import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wo_skills/pages/home_screen.dart';
import 'package:wo_skills/tabs/profile_tab.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _pageName = TextEditingController(),
      _pageCategory = TextEditingController(),
      _pageDescription = TextEditingController();
  bool isFileLoading = false;
  final imagePicker = ImagePicker();
  bool isUploadingFile = false;
  File imageFile;

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  ///Open file explorer
  void _openFileExplorer() async {
    //exit if a file is already being loaded
    if (isFileLoading) return;

    //set file loading to true
    setState(() {
      isFileLoading = true;
    });
    //Open file selector and add all its selected files to list

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        print(imageFile);
      });
    }
    setState(() {
      isFileLoading = false;
    });
  }

  // Create profile picture widget
  Widget _createPicWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: GestureDetector(
        onTap: () {
          _openFileExplorer();
        },
        child: Stack(children: const [
          Padding(
            padding: EdgeInsets.only(
              top: 0.0,
              left: 10,
            ),
            child: Icon(
              Icons.image,
              size: 32,
              color: Colors.green,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 45, top: 7),
            child: Text('Photo'),
          )
        ]),
      ),
    );
  }

  // Create image widget
  Widget _createImageWidget() {
    Widget imgWidget;

    //select child
    if (isFileLoading) {
      imgWidget = const CircularProgressIndicator();
    } else if (isUploadingFile) // A file is being uploaded to database
    {
      imgWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Uploading image"),
        ],
      );
    } else if (imageFile != null) {
      imgWidget =
          Image.file(imageFile, width: double.maxFinite, fit: BoxFit.fill);
    }

    return Container(
      width: imageFile == null ? 0 : 350,
      height: imageFile == null ? 0 : 250,
      color: Colors.white,
      child: Center(
        child: imgWidget,
      ),
    );
  }

  static final FirebaseFirestore _store = FirebaseFirestore.instance;
  Future<void> uploadInsuranceImage(File imageFile) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    //var ext = path.extension(imageFile.path);
    await _storage.ref().child(uid).child(_pageName.text).putFile(imageFile);
    var url =
        await _storage.ref().child(uid).child(_pageName.text).getDownloadURL();
    var doc = _store
        .collection('woknack_users')
        .doc(uid)
        .collection('pages')
        .doc(_pageName.text);

    await doc.set({
      'page_name': _pageName.text,
      'page_category': _pageCategory.text,
      'page_description': _pageDescription.text,
      'url': url,
    }, SetOptions(merge: true));

    var docForPage = _store.collection('pages').doc(uid);

    await doc.set({
      'page_name': _pageName.text,
      'page_category': _pageCategory.text,
      'page_description': _pageDescription.text,
      'url': url,
    }, SetOptions(merge: true));
    await docForPage.set({
      'page_name': _pageName.text,
      'page_category': _pageCategory.text,
      'page_description': _pageDescription.text,
      'url': url,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          children: [
            Text(
              'Create a Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Page information'),
            SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: false,
              textInputAction: TextInputAction.next,
              controller: _pageName,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Page Name",
                border: OutlineInputBorder(),
                hintText: 'Enter page name',
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
                hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 10.0,
                ),
              ),
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: false,
              textInputAction: TextInputAction.next,
              controller: _pageCategory,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Page Category ",
                border: OutlineInputBorder(),
                hintText: 'Enter category',
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
                hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 10.0,
                ),
              ),
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: false,
              textInputAction: TextInputAction.next,
              controller: _pageDescription,
              maxLines: 5,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Page Description",
                border: OutlineInputBorder(),
                hintText: 'Enter description',
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
                hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 10.0,
                ),
              ),
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            _createPicWidget(),
            _createImageWidget(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      top: 10, left: 40, right: 40, bottom: 10),
                  primary: Colors.blueAccent[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32))),
              child: const Text('Create Page',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
              onPressed: () {
                uploadInsuranceImage(imageFile);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => MyHomePage()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
