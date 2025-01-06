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

  Future<Map<String, dynamic>?> signUp(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/signup',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
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

  Future<Map<String, dynamic>?> requestPasswordReset(email) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/request-reset-password',
        data: {
          'email': email,
        }
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

  Future<bool> resetPassword(int resetCode, String newPassword) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/reset-password',
        data: {
          'resetCode': resetCode,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

 Future<Map<String, dynamic>?> verifyEmail(String email, String code) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/verify-email',
        data: {'email': email, 'code': code},
      );

      return response.data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
