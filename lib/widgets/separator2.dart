import 'package:flutter/material.dart';

class SeparatorWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: MediaQuery.of(context).size.width,
      height: 5.0,
    );
  }
}
