import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: '_id')
  final String id;

  final String authorId;
  final String title;
  final int price;
  final String description;
  final String serviceType;
  final String regions;
  final String comuna;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.price,
    required this.description,
    required this.serviceType,
    required this.regions,
    required this.comuna,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
