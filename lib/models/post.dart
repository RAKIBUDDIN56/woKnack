class Post {
  final String profileImageUrl;
  final String username;
  final String time;
  final String content;
  final String likes;
  final String comments;
  final String shares;

  Post(
      {this.profileImageUrl,
      this.username,
      this.time,
      this.content,
      this.likes,
      this.comments,
      this.shares});
}

List<Post> posts = [
  new Post(
    profileImageUrl: 'assets/cooking.jpg',
    username: 'Cooking Hub',
    time: '1h',
    content:
        'The cooking is your hobby, it will be something fun to do but not something that you let take over more and more of your life. If cooking is your passion',
    likes: '77',
    comments: '7',
  ),
  new Post(
    profileImageUrl: 'assets/dancing.jpg',
    username: 'Dancing Hum',
    time: '5h',
    content:
        'For many, dancing is considered a passion (Vallerand et al., 2003). Given that social dance communities organize both social dance events and dance competitions,',
    likes: '63',
    comments: '11',
  ),
];
