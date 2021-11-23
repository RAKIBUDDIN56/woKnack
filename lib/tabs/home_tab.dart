import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wo_skills/widgets/separator2.dart';
import 'package:wo_skills/widgets/write_something_widget.dart';
import 'package:wo_skills/widgets/separator_widget.dart';
import 'package:wo_skills/widgets/post_widget.dart';
import 'package:wo_skills/widgets/stories_widget.dart';
import 'package:wo_skills/models/post.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  String URL;
  Future<void> fetUrl() async {
    var data = await FirebaseFirestore.instance
        .collection('woknack_users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('pages')
        .doc('Tast me')
        .get();
    URL = data.data()['url'];
  }

  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _driverStream = FirebaseFirestore.instance
        .collection('woknack_users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('posts')
        .snapshots();
    return SingleChildScrollView(
      child: Column(
        children: [
          WriteSomethingWidget(),
          //SeparatorWidget(),
          // OnlineWidget(),
          SeparatorWidget2(),
          StoriesWidget(),
          StreamBuilder<QuerySnapshot>(
              stream: _driverStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something is wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }
                // String u = fetUrl().toString();

                return Column(
                  //shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  children: snapshot.data.docs
                      .map((DocumentSnapshot documentSnapshot) {
                    Map<String, dynamic> data =
                        documentSnapshot.data() as Map<String, dynamic>;

                    // return ListTile(
                    //   title:
                    //       Text(data['online'] == true ? data['name'] : 'No'),
                    //   subtitle: Text(data['phone']),
                    // );
                    return Container(
                      // padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(data['url']),
                                  radius: 20.0,
                                ),
                                SizedBox(width: 7.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(data['selected_page'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0)),
                                    SizedBox(height: 5.0),
                                    Text('1min')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Text(data['post'],
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 15.0)),
                          ),
                          SizedBox(height: 10.0),
                          SeparatorWidget(),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     Row(
                          //       children: <Widget>[
                          //         Icon(FontAwesomeIcons.thumbsUp,
                          //             size: 15.0, color: Colors.blue),
                          //         Text('4'),
                          //       ],
                          //     ),
                          //     Row(
                          //       children: <Widget>[
                          //         Text('4'),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Divider(height: 30.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[
                          //     Row(
                          //       children: <Widget>[
                          //         Icon(FontAwesomeIcons.thumbsUp, size: 20.0),
                          //         SizedBox(width: 5.0),
                          //         Text('Like',
                          //             style: TextStyle(fontSize: 14.0)),
                          //       ],
                          //     ),
                          //     Row(
                          //       children: <Widget>[
                          //         Icon(FontAwesomeIcons.commentAlt, size: 20.0),
                          //         SizedBox(width: 5.0),
                          //         Text('Comment',
                          //             style: TextStyle(fontSize: 14.0)),
                          //       ],
                          //     ),
                          //     // Row(
                          //     //   children: <Widget>[
                          //     //     Icon(FontAwesomeIcons.share, size: 20.0),
                          //     //     SizedBox(width: 5.0),
                          //     //     Text('Share', style: TextStyle(fontSize: 14.0)),
                          //     //   ],
                          //     // ),
                          //   ],
                          // )
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),

          for (Post post in posts)
            Column(
              children: <Widget>[
                PostWidget(post: post),
              ],
            ),
          SeparatorWidget(),
        ],
      ),
    );
  }
}
