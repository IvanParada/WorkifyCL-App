import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PostDatasource {
  PostDatasource({required Dio dio}) : _dio = dio;

  final _storage = const FlutterSecureStorage();
  final Dio _dio;

  Future<Map<String, dynamic>?> createPost(postData) async {
    final token = await _storage.read(key: 'accessToken');

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/posts',
        data: postData.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        return response.data;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<dynamic>?>  getPosts() async {
    final token = await _storage.read(key: 'accessToken');

    try {
      final response = await _dio.get<List<dynamic>> (
        '/posts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Map<String,dynamic>?>  getPostsById(String id) async {
    final token = await _storage.read(key: 'accessToken');

    try {
      final response = await _dio.get<Map<String,dynamic>?> (
        '/posts/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<dynamic>?> getLocations() async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/locations',
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
