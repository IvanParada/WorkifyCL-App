
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// ***************************************************************************
// JsonSerializableGenerator
// ***************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) {
  return CreatePostModel(
    title: json['title'] as String,
    price: (json['price'] as num).toDouble(),
    paymentType: json['paymentType'] as String,
    description: json['description'] as String,
    serviceType: json['serviceType'] as String,
    regions: json['regions'] as String,
    comuna: json['comuna'] as String,
  );
}

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) => <String, dynamic>{
      'title': instance.title,
      'price': instance.price,
      'paymentType': instance.paymentType,
      'description': instance.description,
      'serviceType': instance.serviceType,
      'regions': instance.regions,
      'comuna': instance.comuna,
    };
