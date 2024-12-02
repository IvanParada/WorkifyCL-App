import 'package:json_annotation/json_annotation.dart';

part 'locations_model.g.dart';

@JsonSerializable()
class LocationsModel {
  final String name;
  final List<String> communes;

  LocationsModel({
    required this.name,
    required this.communes,
  });

  factory LocationsModel.fromJson(Map<String, dynamic> json) =>
      _$LocationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsModelToJson(this);
}
