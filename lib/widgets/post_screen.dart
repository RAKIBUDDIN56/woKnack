import 'dart:convert';
import 'dart:io';
import 'package:wo_skills/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wo_skills/widgets/helperWidgets/process_dialog.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextStyle textStyle = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  /// Detects if a file is being loaded drom file explorer
  bool isFileLoading = false;
  bool isFileLoadingVideo = false;

  ///Detects if the profile image is being uploaded
  bool isUploadingFile = false;
  bool isUploadingFileVideo = false;

  /// Profile image file
  final imagePicker = ImagePicker();
  File imageFile;
  File videoFile;

  Widget _buildTextField() {
    const maxLines = 10;

    return Container(
      margin: const EdgeInsets.all(12),
      height: maxLines * 24.0,
      child: TextField(
        controller: nameTextEditingController,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: "Enter a text",
          fillColor: Colors.grey[300],
          filled: true,
        ),
      ),
    );
  }

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

  ///Open file explorer for video
  ///
  void _openFileExplorerForVideo() async {
    //exit if a file is already being loaded
    if (isFileLoadingVideo) return;

    //set file loading to true
    setState(() {
      isFileLoadingVideo = true;
    });
    //Open file selector and add all its selected files to list

    final pickedImage =
        await imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        videoFile = File(pickedImage.path);
        print(videoFile);
      });
    }
    setState(() {
      isFileLoadingVideo = false;
    });
  }

  String result = '';

  ///video upload method
  Future<String> doUploadVideo() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.8.101:5000/videoToText/"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'video',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: videoFile.toString(),
        contentType: MediaType('video', 'mp4'),
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // var result = json.decode(response);
        var resp = response.stream.bytesToString();

        // _onBasicAlertPressed(context, value);
        print(resp);
        return resp;

        // return result;
      }
    } catch (e) {
      debugPrint("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
    // return result;
  }

  //METHOD TO PREDICT CATEGORY
  Future<String> predictCategory(String body) async {
    var client = http.Client();
    //for emulator
    //url for imulator
    //var uri = Uri.parse("http://10.0.2.2:5000/predict");
    var uri = Uri.parse("http://192.168.8.101:5000/predict");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = json.encode(body);
    try {
      var resp = await client.post(uri, headers: headers, body: jsonString);
      //var resp=await http.get(Uri.parse("http://192.168.1.101:5000"));
      if (resp.statusCode == 200) {
        debugPrint("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(resp.body);
        debugPrint(result["prediction"]);
        return result["prediction"];
      }
    } catch (e) {
      debugPrint("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }

  //METHOD TO PREDICT NEGATIVE POST
  Future<String> predictNegativePost(String body) async {
    var client = http.Client();
    //for emulator
    //url for imulator
    //var uri = Uri.parse("http://10.0.2.2:5000/predict");
    var uri = Uri.parse("http://192.168.8.101:5000/negativePostAnanlysis");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = json.encode(body);
    try {
      var response = await client.post(uri, headers: headers, body: jsonString);
      //var resp=await http.get(Uri.parse("http://192.168.1.101:5000"));
      if (response.statusCode == 200) {
        debugPrint("DATA FETCHED SUCCESSFULLY");
        // var result = json.decode(response);
        var resp = response.body;

        // _onBasicAlertPressed(context, value);
        print(resp);
        return resp;
      }
    } catch (e) {
      debugPrint("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }

  ///image upload method
  Future<String> doUpload() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.8.101:5000/imageToText/"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: imageFile.toString(),
        contentType: MediaType('image', 'jpg'),
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // var result = json.decode(response);
        var resp = response.stream.bytesToString();

        // _onBasicAlertPressed(context, value);
        print(resp);
        return resp;

        // return result;
      }
    } catch (e) {
      debugPrint("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
    // return result;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0),
        child: Column(
          children: [
            const SizedBox(height: 55),
            Text('Create a Post', style: textStyle),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 1.0,
                  ),
                  //post field
                  _buildTextField(),
                  const SizedBox(
                    height: 1.0,
                  ),
                  Row(
                    children: [_createPicWidget(), _createVideoWidget()],
                  ),
                  _createImageWidget(),

                  //blood group
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 0, right: 270, bottom: 4, top: 20),
                    child: Text('Select Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        contentPadding: const EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            hint: Text(categoryDropDownValue),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black45),
                            focusColor: Colors.blue,
                            isDense: true,
                            isExpanded: true,
                            items: categoryList.map((item) {
                              return DropdownMenuItem<String>(
                                child: Text(item),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                categoryDropDownValue = value;
                                debugPrint(categoryDropDownValue);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  //contact number field
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        hintText: 'Page Name',
                        //prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 50),
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: const SizedBox(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "POST",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      onPressed: () => _btnHndler(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  //submit button handler
  void _btnHndler() async {
    if (categoryDropDownValue == 'Select a category') {
      displayToastMessage('Select a category', context);
    } else {
      showDialog(
          context: context,
          builder: (_) => ProgressDialog(
                message: 'Please wait....',
              ));
      print('Clikced');
      //var resp = await doUpload();
      // await predictCategory(nameTextEditingController.text);
      // _onBasicAlertPressed(context, resp);
      print('Category isssss');
      // var res = await doUploadVideo();
      var res = await predictNegativePost('Love good');
      // print(resp);
      _onBasicAlertPressed(context, res, 'Category :');
      // doUpload();
    }
  }

  //function from rflutter pkg to display alert
  _onBasicAlertPressed(context, String title, resp) {
    Alert(context: context, title: title, desc: resp).show();
  }

  /// Create profile picture widget
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

  // Create profile picture widget
  Widget _createVideoWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: GestureDetector(
        onTap: () {
          _openFileExplorerForVideo();
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
            child: Text('Video'),
          )
        ]),
      ),
    );
  }
  // Widget _verticalDivider() {
  //   return VerticalDivider(
  //     color: Colors.red,
  //     thickness: 2,
  //     indent: 4,
  //     endIndent: 4,
  //   );
  // }
}
