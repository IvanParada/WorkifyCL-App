import 'dart:convert';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class HttpClient {
  final _client = http.Client();
  final _storage = const FlutterSecureStorage();
  final AuthenticationCubit authCubit;

  HttpClient({required this.authCubit});

  Future<bool> isTokenExpired() async {
    final token = await _storage.read(key: 'accessToken');

    if (token == null) {
      return true; 
    }

    try {
      final expirationDate = Jwt.getExpiryDate(token);

      if (expirationDate == null) {
        return true;
      }

      final now = DateTime.now();
      final difference = expirationDate.difference(now).inSeconds;

      return difference < 300;
    } catch (e) {
      return true; 
    }
  }

  Future<void> updateToken() async {
    final email = await _storage.read(key: 'email');
    final password = await _storage.read(key: 'password');

    if (email == null || password == null) {
      throw Exception('Credenciales no encontradas para relogin.');
    }

    authCubit.logIn(email, password);

    final newToken = authCubit.state.loginUserData?.token;
    if (newToken != null) {
      await _storage.write(key: 'accessToken', value: newToken);
    } else {
      throw Exception('Error al actualizar el token.');
    }
  }

  Future<http.Response> get(Uri url) async {
    if (await isTokenExpired()) {
      await updateToken();
    }

    final token = await _storage.read(key: 'accessToken');

    return _client.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<http.Response> post(Uri url, Map<String, dynamic> body) async {
    if (await isTokenExpired()) {
      await updateToken();
    }

    final token = await _storage.read(key: 'accessToken');

    return _client.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }
}
