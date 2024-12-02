import 'dart:developer';
import 'package:dio/dio.dart';

class PostDatasource {
  PostDatasource({required Dio dio}) : _dio = dio;

  final Dio _dio;

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
