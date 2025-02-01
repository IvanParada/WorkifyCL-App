// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostIdModel _$PostIdModelFromJson(Map<String, dynamic> json) => PostIdModel(
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      paymentType: json['paymentType'] as String,
      description: json['description'] as String,
      serviceType: json['serviceType'] as String,
      regions: json['regions'] as String,
      comuna: json['comuna'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      authorEmail: json['authorEmail'] as String,
    );

Map<String, dynamic> _$PostIdModelToJson(PostIdModel instance) => <String, dynamic>{
      'title': instance.title,
      'price': instance.price,
      'paymentType': instance.paymentType,
      'description': instance.description,
      'serviceType': instance.serviceType,
      'regions': instance.regions,
      'comuna': instance.comuna,
      'createdAt': instance.createdAt.toIso8601String(),
      'authorEmail': instance.authorEmail,
    };