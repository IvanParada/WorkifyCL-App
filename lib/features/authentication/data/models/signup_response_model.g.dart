// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponseModel _$SignUpResponseModelFromJson(Map<String, dynamic> json) {
  return SignUpResponseModel(
    isVerified: json['isVerified'] as bool,
    verificationCode: json['verificationCode'] as String,
  );
}

Map<String, dynamic> _$SignUpResponseModelToJson(SignUpResponseModel instance) =>
    <String, dynamic>{
      'isVerified': instance.isVerified,
      'verificationCode': instance.verificationCode,
    };
