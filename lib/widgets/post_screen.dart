import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wo_skills/pages/home_screen.dart';
import 'package:wo_skills/widgets/helperWidgets/output_dialog.dart';
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
  bool isFileLoading = false;
  bool isFileLoadingVideo = false;
  bool isUploadingFile = false;
  bool isUploadingFileVideo = false;
  final imagePicker = ImagePicker();
  File imageFile;
  File videoFile;
  static final FirebaseFirestore _store = FirebaseFirestore.instance;
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
  Future<String> predictPage(List body) async {
    var client = http.Client();
    //for emulator
    //url for imulator
    //var uri = Uri.parse("http://10.0.2.2:5000/predict");
    var uri = Uri.parse("http://192.168.8.101:5000/pagepredict");
    Map<String, String> headers = {"Content-type": "application/json"};
    var jsonString = json.encode(body);
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
  Future<String> doUploadImage() async {
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

//METHOD TO PREDICT NEGATIVE POST
  Future<String> gender(String body) async {
    var client = http.Client();

    var uri = Uri.parse("http://192.168.8.101:5000/gender");
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

  var setDefaultMake = true, setDefaultMakeModel = true;
  var selecetedCategory;
  var setDefaultMakePage = true, setDefaultMakeModelPage = true;
  var selecetedPage, carMakeModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20),
          children: [
            const SizedBox(height: 55),
            Text('Create a Post',
                textAlign: TextAlign.center, style: textStyle),
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
                        left: 0, right: 250, bottom: 4, top: 20),
                    child: Text('Select Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('woknack_users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('pages')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // Safety check to ensure that snapshot contains data
                        // without this safety check, StreamBuilder dirty state warnings will be thrown
                        if (!snapshot.hasData) return Container();
                        // Set this value for default,
                        // setDefault will change if an item was selected
                        // First item from the List will be displayed
                        if (setDefaultMake) {
                          selecetedCategory =
                              snapshot.data.docs[0].get('page_category');
                          debugPrint('setDefault make: $selecetedCategory');
                        }
                        return InputDecorator(
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
                              child: DropdownButton(
                                isExpanded: false,
                                value: selecetedCategory,
                                items: snapshot.data.docs.map((value) {
                                  return DropdownMenuItem(
                                    value: value.get('page_category'),
                                    child:
                                        Text('${value.get('page_category')}'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  debugPrint('selected onchange: $value');
                                  setState(
                                    () {
                                      debugPrint('make selected: $value');
                                      // Selected value will be stored
                                      selecetedCategory = value;
                                      // Default dropdown value won't be displayed anymore
                                      setDefaultMake = false;
                                      // Set makeModel to true to display first car from list
                                      setDefaultMakeModel = true;
                                      print(selecetedCategory);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 0, right: 250, bottom: 4, top: 20),
                    child: Text('Select Page',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('woknack_users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('pages')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // Safety check to ensure that snapshot contains data
                        // without this safety check, StreamBuilder dirty state warnings will be thrown
                        if (!snapshot.hasData) return Container();
                        // Set this value for default,
                        // setDefault will change if an item was selected
                        // First item from the List will be displayed
                        if (setDefaultMakePage) {
                          selecetedPage =
                              snapshot.data.docs[0].get('page_name');
                          debugPrint('setDefault make: $selecetedPage');
                        }
                        return InputDecorator(
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
                              child: DropdownButton(
                                isExpanded: false,
                                value: selecetedPage,
                                items: snapshot.data.docs.map((value) {
                                  return DropdownMenuItem(
                                    value: value.get('page_name'),
                                    child: Text('${value.get('page_name')}'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  debugPrint('selected onchange: $value');
                                  setState(
                                    () {
                                      debugPrint('make selected: $value');
                                      // Selected value will be stored
                                      selecetedPage = value;
                                      // Default dropdown value won't be displayed anymore
                                      setDefaultMakePage = false;
                                      // Set makeModel to true to display first car from list
                                      setDefaultMakeModelPage = true;
                                      print(selecetedPage);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //contact number field
                  const SizedBox(
                    height: 20.0,
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
        ));
  }

  Future<void> uploadInsuranceImage(String text) async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    //var ext = path.extension(imageFile.path);
    // await _storage.ref().child(uid).child(_pageName.text).putFile(imageFile);
    var url =
        await _storage.ref().child(uid).child(selecetedPage).getDownloadURL();

    var doc = _store
        .collection('woknack_users')
        .doc(uid)
        .collection('posts')
        .doc(text.substring(0, 3));
    var docPage = _store
        .collection('woknack_users')
        .doc(uid)
        .collection('pages')
        .doc(selecetedPage)
        .collection('post')
        .doc(text.substring(0, 3));

    await doc.set({
      'post': text,
      'selected_page': selecetedPage,
      'url': url

      // 'page_description': _pageDescription.text,
      // 'url': url,
    }, SetOptions(merge: true));
    await docPage.set({
      'post': nameTextEditingController.text,
      'selected_page': selecetedPage,
      'url': url

      // 'page_description': _pageDescription.text,
      // 'url': url,
    }, SetOptions(merge: true));
  }

  List list = ['Cooking', 'Dancing', 'Cooking', 'Cooking'];
  var response = '';
  void _btnHndler() async {
    print('Clikced');
    if (nameTextEditingController.text != '' && imageFile == null) {
      print('Text clicked');
      showDialog(
          context: context,
          builder: (_) => ProgressDialog(
                message: 'Please wait....',
              ));
      response = await predictCategory(nameTextEditingController.text);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (_) => Warning(response ?? 'No Result', 'Category : ')));

      var res = await predictNegativePost(response);
      print(res);
      if (response == selecetedCategory && res == 'Positive') {
        uploadInsuranceImage(nameTextEditingController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MyHomePage()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    Warning('ERROR', 'Select correct category to post ')));
        nameTextEditingController.text = '';
      }
    } else if (imageFile != null) {
      print('Image clicked');
      showDialog(
          context: context,
          builder: (_) => ProgressDialog(
                message: 'Please wait....',
              ));
      response = await doUploadImage();
      var res = await predictCategory(response);

      imageFile = null;
      var ress = await predictNegativePost(response);
      print(res);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  Warning(res ?? 'No Result', 'Text from Image : ')));
      if (res == selecetedCategory && ress == 'Positive') {
        uploadInsuranceImage(response);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => MyHomePage()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    Warning('ERROR', 'Select correct category to post ')));
      }
    } else if (videoFile != null) {
      print('Video clicked');
      showDialog(
          context: context,
          builder: (_) => ProgressDialog(
                message: 'Please wait....',
              ));
      response = await doUploadVideo();
      var ress = await predictCategory(response);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  Warning(response ?? 'No Result', ' Text from video : ')));

      //var response = await predictPage(list);
      print(response);
      print('done');
    } else {}

    //_onBasicAlertPressed(context, resp);
  }

  //function from rflutter pkg to display alert
  _onBasicAlertPressed(context, String title, resp) {
    Alert(
        context: context,
        title: title,
        desc: resp,
        closeFunction: () {
          setState(() {});
        }).show();
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
              Icons.video_camera_front,
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
}
