// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: Review._stringToInt(json['id'] as String),
      comment: json['comment'] as String,
      rating: json['rating'] as int,
      showId: json['show_id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
