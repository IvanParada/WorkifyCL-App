
import 'package:json_annotation/json_annotation.dart';

part 'create_post_model.g.dart';

@JsonSerializable()
class CreatePostModel {
  final String title;
  final double price;
  final String paymentType;
  final String description;
  final String serviceType;
  final String regions;
  final String comuna;

  CreatePostModel({
    required this.title,
    required this.price,
    required this.paymentType,
    required this.description,
    required this.serviceType,
    required this.regions,
    required this.comuna,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) => _$CreatePostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);
}
