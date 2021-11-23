import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ComputerServeice {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> getMainImage() async {
    var downloadURL = await _storage
        .ref()
        .child('intel workstation')
        .child('main image')
        .child('main_image.png')
        .getDownloadURL();

    return downloadURL;
  }

  static void getMainImageURL() async {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    var url = await ComputerServeice.getMainImage();

    await _firebaseFirestore
        .collection('computer')
        .doc('intel_workstation')
        .set({'main_image_URL': url}, SetOptions(merge: true));
  }

  static Future<String> getDetailImage() async {
    var downloadURL = await _storage
        .ref()
        .child('intel workstation')
        .child('detail image')
        .child('detail_image.png')
        .getDownloadURL();

    return downloadURL;
  }

  static void getDetailImageURL() async {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    var url = await ComputerServeice.getDetailImage();

    await _firebaseFirestore
        .collection('computer')
        .doc('intel_workstation')
        .set({
      'detail_image_URL': url,
    }, SetOptions(merge: true));
  }
}
