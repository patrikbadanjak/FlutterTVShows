// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Show _$ShowFromJson(Map<String, dynamic> json) => Show(
      id: Show._stringToInt(json['id'] as String),
      name: json['title'] as String,
      description: json['description'] as String,
      numOfReviews: json['no_of_reviews'] as int,
      averageRating: (json['average_rating'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
    );
