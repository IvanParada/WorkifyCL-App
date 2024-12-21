import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:Workify/core/enums/enums_state.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/features/authentication/data/models/login_response_model.dart';
import 'package:Workify/features/authentication/data/models/request_reset_password_model.dart';
import 'package:Workify/features/authentication/data/models/signup_response_model.dart';
import 'package:Workify/features/authentication/data/repository/auth_repository.dart';
import 'package:Workify/features/authentication/presentation/widgets/dialog_widget.dart';

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

    emit(state.copyWith(status: Status.failureLogin));
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

  Future<void> requestResetPassword(email, context) async {
    emit(state.copyWith(status: Status.loading));
    setEmailResetPass(email);
    final res = await authRepository.requestResetPassword(email);

    if (res != null) {
      emit(state.copyWith(codeRequestResetPass: res));
      showCustomAnimatedDialog(
        context: context,
        title: '¡Correo enviado!',
        message: 'Verifica tu bandeja de entrada e ingresa el código.',
        colorTypeDialog: AppColors.info,
        icon: SvgAssets.logoApp,
        onTap: () {
          Navigator.of(context).pop();
          GoRouter.of(context).go('/recovery-step-2');
        },
      );

      return;
    }

    showCustomAnimatedDialog(
      context: context,
      title: '¡Ups!',
      message: 'Ha ocurrido un problema al enviar el correo.',
      colorTypeDialog: AppColors.warning,
      icon: SvgAssets.logoApp,
      onTap: () {
        context.pop();
      },
    );
  }

  Future<void> resetPassword(String newPassword, context) async {
    emit(state.copyWith(status: Status.loading));
    final code = int.parse(state.setCodeResetPass!);
    final res = await authRepository.resetPassword(code, newPassword);

    if (res) {
      showCustomAnimatedDialog(
        context: context,
        title: '¡Bienvenido nuevamente!',
        message: 'Tu contraseña ha sido actualizada exitosamente.',
        colorTypeDialog: AppColors.success,
        icon: SvgAssets.logoApp,
        onTap: () {
          Navigator.of(context).pop();
          GoRouter.of(context).go('/signin');
        },
      );
    }
  }

  void setCodeResetPass(String code) {
    emit(state.copyWith(setCodeResetPass: code));
  }

  void setEmailResetPass(String email) {
    emit(state.copyWith(setEmailResetPass: email));
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
        showCustomAnimatedDialog(
          context: context,
          title: '¡Bienvenido!',
          message: 'Has sido registrado exitosamente.',
          onTap: () {
            Navigator.of(context).pop();
            GoRouter.of(context).go('/signin');
          },
        );
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
