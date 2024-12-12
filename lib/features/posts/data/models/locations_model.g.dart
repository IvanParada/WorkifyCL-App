// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsModel _$LocationsModelFromJson(Map<String, dynamic> json) =>
    LocationsModel(
      name: json['name'] as String,
      communes:
          (json['communes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LocationsModelToJson(LocationsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'communes': instance.communes,
    };
