import 'dart:developer';
import 'package:dio/dio.dart';

class AuthDatasource {
  AuthDatasource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.data != null) {
        return response.data;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
