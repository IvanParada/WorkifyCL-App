import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:workify_cl_app/core/enums/enums_state.dart';
import 'package:workify_cl_app/features/authentication/data/models/login_response_model.dart';
import 'package:workify_cl_app/features/authentication/data/repository/auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.secureStorage, {required this.authRepository})
      : super(const AuthenticationState());

  final AuthRepository authRepository;
  final FlutterSecureStorage secureStorage;

  void logIn(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final res = await authRepository.loginUser(email, password);

    if (res != null) {
      await secureStorage.write(key: 'email', value: email);
      await secureStorage.write(key: 'password', value: password);

      await secureStorage.write(key: 'accessToken', value: res.token);

      emit(state.copyWith(
        loginUserData: res,
        status: Status.success,
      ));
      print(res.token);
      return;
    }

    emit(state.copyWith(status: Status.failure));
  }

  void showPassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void showRepeatPassword() {
    emit(state.copyWith(obscureRepeatPassword: !state.obscureRepeatPassword));
  }

  void logOut() async {
    await secureStorage.deleteAll();
    emit(state.copyWith(status: Status.initial));
  }

  Future<bool> validateToken() async {
    try {
      final token = await secureStorage.read(key: 'accessToken');

      if (token == null) {
        emit(state.copyWith(status: Status.initial));
        return false;
      }

      final isExpired =
          Jwt.getExpiryDate(token)?.isBefore(DateTime.now()) ?? true;

      if (isExpired) {
        final email = await secureStorage.read(key: 'email');
        final password = await secureStorage.read(key: 'password');

        if (email == null || password == null) {
          emit(state.copyWith(status: Status.initial));

          return false;
        }

        logIn(email, password);
        return true;
      }

      emit(state.copyWith(
        status: Status.success,
        loginUserData: state.loginUserData,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(status: Status.initial));

      return false;
    }
  }
}
