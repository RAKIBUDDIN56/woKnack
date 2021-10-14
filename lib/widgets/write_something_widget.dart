import 'package:wo_skills/widgets/post_screen.dart';
import 'package:flutter/material.dart';

class WriteSomethingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 28.0,
                  backgroundImage: AssetImage('assets/ashvini.jpg'),
                ),
                SizedBox(width: 7.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  height: 70.0,
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(35.0)),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PostScreen()));
                      print('hello');
                    },
                    decoration: InputDecoration(
                        hintText: 'Write Something Here',
                        border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
