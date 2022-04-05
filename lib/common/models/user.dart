import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User {
  User(this.id, this.email, this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromHive(Box<dynamic> box) {
    return User(
      box.get('id'),
      box.get('email'),
      box.get('imageUrl') as String?,
    );
  }

  final String id;
  String email;
  @JsonKey(name: 'image_url')
  String? imageUrl;
}
