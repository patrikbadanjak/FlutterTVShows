class Show {
  int id;

  @JsonKey(name: 'title')
  String name;
  String description;

  @JsonKey(name: 'no_of_reviews')
  int numOfReviews;

  @JsonKey(name: 'average_rating')
  double averageRating;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  Show({
    required this.id,
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
      description:
          'In 1980s Indiana, a group of young friends witness supernatural forces and secret government exploits. As they search for answers, the children unravel a series of extraordinary mysteries.',
      numOfReviews: 3,
      averageRating: 4.0,
      imageUrl: 'assets/images/shows/stranger_things.png',
    ),
    Show(
      name: 'The Office',
      description:
          'The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company. It aired on NBC from March 24, 2005, to May 16, 2013, lasting a total of nine seasons.',
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
