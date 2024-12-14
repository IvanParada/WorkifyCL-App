import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:workify_cl_app/core/enums/enums_state.dart';
import 'package:workify_cl_app/features/authentication/data/models/login_response_model.dart';
import 'package:workify_cl_app/features/authentication/data/models/signup_response_model.dart';
import 'package:workify_cl_app/features/authentication/data/repository/auth_repository.dart';
import 'package:workify_cl_app/features/authentication/presentation/widgets/dialog_widget.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.secureStorage, {required this.authRepository})
      : super(const AuthenticationState());

  final AuthRepository authRepository;
  final FlutterSecureStorage secureStorage;

  Future<void> logIn(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final res = await authRepository.loginUser(email, password);

    if (res != null) {
      await secureStorage.write(key: 'email', value: email);
      await secureStorage.write(key: 'password', value: password);

      await secureStorage.write(key: 'accessToken', value: res.token);

      emit(state.copyWith(
        loginUserData: res,
        status: Status.successLogin,
      ));
      return;
    }

    emit(state.copyWith(status: Status.failure));
  }

  Future<void> signUp(
      String name, String email, String password, int userPhone) async {
    emit(state.copyWith(status: Status.loading));

    final res = await authRepository.signUp(name, email, password, userPhone);
    if (res != null) {
      emit(state.copyWith(
        signupUserData: res,
        status: Status.success,
      ));
      log('===> CODIGO REGISTRO: ${state.signupUserData!.verificationCode}');
      return;
    }

    emit(state.copyWith(status: Status.failure));
  }

  Future<void> requestResetPassword() async {
    emit(state.copyWith(status: Status.loading));

    await authRepository.requestResetPassword();
    //TODO: ADD SHOWDIALOG
  }

  Future<void> resetPassword(int resetCode, String newPassword) async {
    emit(state.copyWith(status: Status.loading));

    await authRepository.resetPassword(resetCode, newPassword);
    //TODO: ADD REPOSITORY
  }

  Future<void> verifyEmail(email, code, context) async {
    emit(state.copyWith(status: Status.loading));
    final res = await authRepository.verifyEmail(email, code);
    if (res) {
      emit(state.copyWith(
        status: Status.successVerify,
        verifyMessage: res,
      ));

      if (state.status == Status.successVerify || state.verifyMessage!) {
        showDialog<void>(
            context: context,
            barrierColor: Colors.black54,
            builder: (context) {
              return DialogWidget(
                title: '¡Bienvenido!',
                message: 'Has sido registrado exitosamente.',
                onTap: () {
                  context.pop();
                  context.go('/signin');
                },
              );
            });
      }
      return;
    }

    emit(state.copyWith(status: Status.failure));
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
}
