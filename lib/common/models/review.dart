class Review {
  String comment;
  int rating;
  String userEmail;
  String imageUrl;

  Review({required this.comment, required this.rating, required this.userEmail, required this.imageUrl});

  static final allReviews = [
    Review(
      comment: 'Like soooo goood omfg 🥵🥵',
      rating: 5,
      userEmail: 'davolimkrvnijevodakakosiznao@mail.com',
      imageUrl: 'assets/images/ic_profile_placeholder.png',
    ),
    Review(
      comment: 'Brutalno',
      rating: 5,
      userEmail: 'krvnijevodaobozavatelj@mail.com',
      imageUrl: 'assets/images/ic_profile_placeholder.png',
    ),
    Review(
      comment: '',
      rating: 5,
      userEmail: 'anon@mail.com',
      imageUrl: 'assets/images/ic_profile_placeholder.png',
    ),
  ];
}
