import 'package:wo_skills/widgets/separator2.dart';
import 'package:wo_skills/widgets/write_something_widget.dart';
import 'package:wo_skills/widgets/separator_widget.dart';
import 'package:wo_skills/widgets/post_widget.dart';
import 'package:wo_skills/widgets/stories_widget.dart';
import 'package:wo_skills/models/post.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          WriteSomethingWidget(),
          //SeparatorWidget(),
          // OnlineWidget(),
          SeparatorWidget2(),
          StoriesWidget(),
          for (Post post in posts)
            Column(
              children: <Widget>[
                SeparatorWidget(),
                PostWidget(post: post),
              ],
            ),
          SeparatorWidget(),
        ],
      ),
    );
  }
}
