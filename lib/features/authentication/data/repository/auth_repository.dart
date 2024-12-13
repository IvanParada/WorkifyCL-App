import 'dart:developer';

import 'package:workify_cl_app/features/authentication/data/datasource/auth_datasource.dart';
import 'package:workify_cl_app/features/authentication/data/models/login_response_model.dart';
import 'package:workify_cl_app/features/authentication/data/models/signup_response_model.dart';

class AuthRepository {
  AuthRepository({
    required this.authDatasource,
  });

  final AuthDatasource authDatasource;

  Future<LoginResponseModel?> loginUser(String email, String password) async {
    try {
      final response = await authDatasource.loginUser(email, password);

      if (response != null) {
        return LoginResponseModel.fromJson(response);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<SignUpResponseModel?> signUp(
    String name,
    String email,
    String password,
    int userPhone,
  ) async {
    try {
      final response = await authDatasource.signUp(
        name,
        email,
        password,
        userPhone,
      );

      if (response != null) {
        return SignUpResponseModel.fromJson(response);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> requestResetPassword() async {
    try {
      return await authDatasource.requestPasswordReset();
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword(int resetCode, String newPassword) async {
    try {
      return await authDatasource.resetPassword(resetCode, newPassword);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> verifyEmail(String email, String code) async {
    try {
      final response = await authDatasource.verifyEmail(email, code);

      if (response != null && response['message'] != null) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
