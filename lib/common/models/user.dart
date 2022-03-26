import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: false)
class User {
  User(this.id, this.email, this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String id;
  String email;
  @JsonKey(name: 'image_url')
  String? imageUrl;
}
