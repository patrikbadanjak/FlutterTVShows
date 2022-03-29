import 'package:json_annotation/json_annotation.dart';
import 'package:tv_shows/common/models/user.dart';

part 'review.g.dart';

@JsonSerializable(createToJson: false)
class Review {
  @JsonKey(fromJson: _stringToInt)
  int id;
  String comment;
  int rating;

  @JsonKey(name: 'show_id')
  int showId;
  User user;

  Review({
    required this.id,
    required this.comment,
    required this.rating,
    required this.showId,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  static int _stringToInt(String number) => number.isEmpty ? -1 : int.parse(number);
}
