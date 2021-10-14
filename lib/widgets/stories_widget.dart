import 'package:flutter/material.dart';

class StoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 15.0),
          Card(
            semanticContainer: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/cooking.jpg',
                  width: 100,
                  height: 100,
                ),
                Text('Cooking Hub'),
                OutlinedButton(onPressed: () {}, child: Text('Visit'))
              ],
            ),
          ),
          SizedBox(width: 10.0),
          Card(
            semanticContainer: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/dancing.jpg',
                  width: 100,
                  height: 100,
                ),
                Text('Dancing Hub'),
                OutlinedButton(onPressed: () {}, child: Text('Visit'))
              ],
            ),
          ),
          SizedBox(width: 10.0),
          Card(
            semanticContainer: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/swimming.jpg',
                  width: 100,
                  height: 100,
                ),
                Text('Swimming Hub'),
                OutlinedButton(onPressed: () {}, child: Text('Visit'))
              ],
            ),
          ),
          SizedBox(width: 10.0),
          Card(
            semanticContainer: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/story4.jpg',
                  width: 100,
                  height: 100,
                ),
                Text('Cooking Hub'),
                OutlinedButton(onPressed: () {}, child: Text('Visit'))
              ],
            ),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story5.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Card(
            semanticContainer: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/story6.jpg',
                  width: 100,
                  height: 100,
                ),
                Text('Cooking Hub'),
                OutlinedButton(onPressed: () {}, child: Text('Visit'))
              ],
            ),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story7.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 10.0),
          Container(
            width: 120.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story8.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }
}
