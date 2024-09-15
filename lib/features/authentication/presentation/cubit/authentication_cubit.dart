import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workify_cl_app/core/enums/enums_state.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void logIn(String email, String password) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(email: email, password: password));
    emit(state.copyWith(status: Status.success));
  }

  void showPassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
  void showRepeatPassword() {
    emit(state.copyWith(obscureRepeatPassword: !state.obscureRepeatPassword));
  }
}
