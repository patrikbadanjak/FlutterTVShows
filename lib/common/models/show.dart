import 'package:freezed_annotation/freezed_annotation.dart';

part 'show.g.dart';

@JsonSerializable(createToJson: false)
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

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
}
