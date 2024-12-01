part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final Status? status;
  final bool obscurePassword;
  final bool obscureRepeatPassword;
  final String? email;
  final String? password;
  final LoginResponseModel? loginUserData;

  const AuthenticationState({
    this.status,
    this.obscurePassword = true,
    this.obscureRepeatPassword = true,
    this.email,
    this.password,
    this.loginUserData,
  });

  AuthenticationState copyWith({
    Status? status,
    bool? obscurePassword,
    bool? obscureRepeatPassword,
    String? email,
    String? password,
    LoginResponseModel? loginUserData,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureRepeatPassword: obscureRepeatPassword ?? this.obscureRepeatPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      loginUserData: loginUserData ?? this.loginUserData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        obscurePassword,
        obscureRepeatPassword,
        email,
        password,
        loginUserData,
      ];
}
