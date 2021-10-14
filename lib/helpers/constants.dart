import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<String> categoryList = [
  'Cooking',
  'Crafting',
  'Dancing',
  'Language',
  'Education',
  'Fashion Designing',
  'Gardening',
  'Drawing and Painting',
  'IT',
  'Home making',
  'Makeup and Beauty',
  'Music',
  'Self defence',
  'Sports, Yoga and Exercise',
  'Travel'
];
String categoryDropDownValue = 'Select a category';

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message, backgroundColor: Colors.black);
}
