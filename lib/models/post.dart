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
  new Post(
    profileImageUrl: 'assets/jeremy.jpg',
    username: 'Jeremy',
    time: '13h',
    content:
        'I am going to make a Flutter complete course, where i will be teaching all the things that a developer would need to know in order to become a great flutter developer. Course is for beginners, and will be taught everything related to flutter from scratch!!',
    likes: '52',
    comments: '1',
  ),
  new Post(
      profileImageUrl: 'assets/mathew.jpg',
      username: 'Mathew Hallberg',
      time: '2d',
      content:
          'Hey guys this is Mathew, I recently created a cool AR/VR application and pushed it to github, interested people can go and see the working of the app. I hope you guys like it!',
      likes: '61',
      comments: '3',
      shares: '2'),
  new Post(
      profileImageUrl: 'assets/eddison.jpg',
      username: 'Eddison',
      time: '1w',
      content:
          'Good afternoon people, hope you are doing well. STAY HOME STAY SAFE. Hope you are healthy and happy. Wish you good health guys :)',
      likes: '233',
      comments: '6',
      shares: '4'),
];
