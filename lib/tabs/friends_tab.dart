import 'package:flutter/material.dart';

class FriendsTab extends StatefulWidget {
  @override
  State<FriendsTab> createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  @override
  Widget build(BuildContext context) {
    bool check = false;
    String text = 'Follow';

    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Pages',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Suggestions',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('My pages',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Divider(height: 30.0),

              Divider(height: 30.0),
              Text('Pages May Interest You',
                  style:
                      TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/rec.jpg'),
                    radius: 40.0,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Food Room',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(text,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0)),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text('Remove',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/music.jpg'),
                    radius: 40.0,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Music club',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text('Follow',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0)),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text('Remove',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.0),

              // SizedBox(height: 20.0),
              // Row(
              //   children: <Widget>[
              //     CircleAvatar(
              //       backgroundImage: AssetImage('assets/sewing.jpg'),
              //       radius: 40.0,
              //     ),
              //     SizedBox(width: 20.0),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text('Sewing Tips',
              //             style: TextStyle(
              //                 fontSize: 16.0, fontWeight: FontWeight.bold)),
              //         SizedBox(height: 15.0),
              //         Row(
              //           children: <Widget>[
              //             Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 35.0, vertical: 10.0),
              //               decoration: BoxDecoration(
              //                   color: Colors.blue,
              //                   borderRadius: BorderRadius.circular(5.0)),
              //               child: Text('Follow',
              //                   style: TextStyle(
              //                       color: Colors.white, fontSize: 15.0)),
              //             ),
              //             SizedBox(width: 10.0),
              //             Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 35.0, vertical: 10.0),
              //               decoration: BoxDecoration(
              //                   color: Colors.grey[300],
              //                   borderRadius: BorderRadius.circular(5.0)),
              //               child: Text('Remove',
              //                   style: TextStyle(
              //                       color: Colors.black, fontSize: 15.0)),
              //             ),
              //           ],
              //         )
              //       ],
              //     )
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // Row(
              //   children: <Widget>[
              //     CircleAvatar(
              //       backgroundImage: AssetImage('assets/tanya.jpg'),
              //       radius: 40.0,
              //     ),
              //     SizedBox(width: 20.0),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text('Tanya',
              //             style: TextStyle(
              //                 fontSize: 16.0, fontWeight: FontWeight.bold)),
              //         SizedBox(height: 15.0),
              //         Row(
              //           children: <Widget>[
              //             Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 35.0, vertical: 10.0),
              //               decoration: BoxDecoration(
              //                   color: Colors.blue,
              //                   borderRadius: BorderRadius.circular(5.0)),
              //               child: Text('Join',
              //                   style: TextStyle(
              //                       color: Colors.white, fontSize: 15.0)),
              //             ),
              //             SizedBox(width: 10.0),
              //             Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 35.0, vertical: 10.0),
              //               decoration: BoxDecoration(
              //                   color: Colors.grey[300],
              //                   borderRadius: BorderRadius.circular(5.0)),
              //               child: Text('Declinee',
              //                   style: TextStyle(
              //                       color: Colors.black, fontSize: 15.0)),
              //             ),
              //           ],
              //         )
              //       ],
              //     )
              //   ],
              // ),
              SizedBox(height: 20.0)
            ],
          )),
    );
  }
}
