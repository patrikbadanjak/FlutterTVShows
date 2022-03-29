// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReview _$UserReviewFromJson(Map<String, dynamic> json) => UserReview(
      showId: json['show_id'] as int,
      rating: json['rating'] as int,
      comment: json['comment'] as String? ?? '',
    );

Map<String, dynamic> _$UserReviewToJson(UserReview instance) =>
    <String, dynamic>{
      'show_id': instance.showId,
      'rating': instance.rating,
      'comment': instance.comment,
    };
