
import 'package:json_annotation/json_annotation.dart';

part 'signup_response_model.g.dart';

@JsonSerializable()
class SignUpResponseModel {
  final bool isVerified;
  final String verificationCode;
  final String email;

  SignUpResponseModel({
    required this.isVerified,
    required this.verificationCode,
    required this.email,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseModelToJson(this);
}
