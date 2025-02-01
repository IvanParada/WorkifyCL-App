import 'package:json_annotation/json_annotation.dart';

part 'post_id_model.g.dart';

@JsonSerializable()
class PostIdModel {
  final String title;
  final int price;
  final String paymentType;
  final String description;
  final String serviceType;
  final String regions;
  final String comuna;
  final DateTime createdAt;
  final String authorEmail;

  PostIdModel({
    required this.title,
    required this.price,
    required this.paymentType,
    required this.description,
    required this.serviceType,
    required this.regions,
    required this.comuna,
    required this.createdAt,
    required this.authorEmail,
  });

  factory PostIdModel.fromJson(Map<String, dynamic> json) => _$PostIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostIdModelToJson(this);
}
