import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? 'http://localhost:3000'
  ));

  static Dio get dio => _dio;
}