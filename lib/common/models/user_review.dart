import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_review.g.dart';

@JsonSerializable()
class UserReview {
  UserReview({required this.showId, required this.rating, this.comment = ''});

  @JsonKey(name: 'show_id')
  int showId;
  int rating;
  String comment;

  Map<String, dynamic> toJson() => _$UserReviewToJson(this);
}
