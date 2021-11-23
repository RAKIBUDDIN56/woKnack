import 'package:flutter/material.dart';
import 'package:wo_skills/pages/home_screen.dart';
import 'package:wo_skills/widgets/post_screen.dart';

class Warning extends StatelessWidget {
  final String messageText;
  final String headingText;
  Warning(this.messageText, this.headingText);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(5.0),
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.0,
              ),
              Text(
                headingText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 11.0,
              ),
              Divider(
                height: 2.0,
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(messageText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              //price text widget

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: RaisedButton(
                    //     onPressed: () async {
                    //       Navigator.pop(context);
                    //     },
                    //     color: Colors.red,
                    //     child: Padding(
                    //       padding: EdgeInsets.all(10.0),
                    //       child: Center(
                    //         child: Text("Back",
                    //             style: TextStyle(
                    //                 fontSize: 15.0,
                    //                 fontWeight: FontWeight.normal,
                    //                 color: Colors.white)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: width / 10,
                    // ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                              (route) => false);
                        },
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text("Okay",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            " • ",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
            child: Text(text,
                style: TextStyle(
                  fontSize: 16.0,
                )))
      ],
    );
  }
}
