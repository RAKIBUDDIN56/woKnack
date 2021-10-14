import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _contentOfFile = "";

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/demoTextFile.txt';
    print(filePath);
    return filePath;
  }

  void saveFile() async {
    File file = File(await getFilePath());
    file.writeAsString(
        "This is my demo text that will be saved to : demoTextFile.txt");
  }

  void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();

    print('File Content: $fileContent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _contentOfFile,
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              onPressed: () => {saveFile()},
              child: Text("Save File"),
            ),
            RaisedButton(
              onPressed: () => {readFile()},
              child: Text("Read File"),
            ),
          ],
        ),
      ),
    );
  }
}
