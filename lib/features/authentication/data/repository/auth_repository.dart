import 'dart:developer';

import 'package:workify_cl_app/features/authentication/data/datasource/auth_datasource.dart';
import 'package:workify_cl_app/features/authentication/data/models/login_response_model.dart';

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
}
