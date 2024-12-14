import 'package:json_annotation/json_annotation.dart';

part 'request_reset_password_model.g.dart';

@JsonSerializable()
class RequestResetPasswordModel {
  final String code;

  RequestResetPasswordModel({required this.code});

  factory RequestResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$RequestResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestResetPasswordModelToJson(this);
}
