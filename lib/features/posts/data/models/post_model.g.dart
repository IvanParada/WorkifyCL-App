// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// ***************************************************************************
// JsonSerializableGenerator
// ***************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['_id'] as String,
      authorId: json['authorId'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      serviceType: json['serviceType'] as String,
      regions: json['regions'] as String,
      comuna: json['comuna'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      '_id': instance.id,
      'authorId': instance.authorId,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'serviceType': instance.serviceType,
      'regions': instance.regions,
      'comuna': instance.comuna,
      'createdAt': instance.createdAt.toIso8601String(),
    };
