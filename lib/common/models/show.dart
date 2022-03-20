class Show {
  String name;
  String description;
  int numOfReviews;
  double averageRating;
  String imageUrl;

  Show({
    required this.name,
    required this.description,
    required this.numOfReviews,
    required this.averageRating,
    required this.imageUrl,
  });

  static final allShows = [
    Show(
      name: 'Krv nije voda',
      description:
          'Stellar. Absolutely amazing. The acting, the cinematography, the dialog. Simply amazing. Worth every minute of your life.',
      numOfReviews: 3,
      averageRating: 5.0,
      imageUrl: 'assets/images/shows/blood_aint_water.png',
    ),
    Show(
      name: 'Stranger Things',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
      numOfReviews: 3,
      averageRating: 4.8,
      imageUrl: 'assets/images/shows/stranger_things.png',
    ),
    Show(
      name: 'The Office',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
      numOfReviews: 0,
      averageRating: 0.0,
      imageUrl: 'assets/images/shows/ured.png',
    ),
    Show(
      name: 'The Sopranos',
      description:
          'Tony Soprano, an Italian-American mafia head based in New Jersey, struggles to manage his family and criminal life and confides his affairs to his psychiatrist Jennifer Melfi.',
      numOfReviews: 12,
      averageRating: 4.9,
      imageUrl: 'assets/images/shows/the_sopranos.jpg',
    ),
  ];
}
