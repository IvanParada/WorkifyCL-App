part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final Status? status;
  final bool obscurePassword;
  final bool obscureRepeatPassword;
  final String? email;
  final String? password;

  const AuthenticationState({
    this.status,
    this.obscurePassword = true,
    this.obscureRepeatPassword = true,
    this.email,
    this.password,
  });

  AuthenticationState copyWith({
    Status? status,
    bool? obscurePassword,
    bool? obscureRepeatPassword,
    String? email,
    String? password
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureRepeatPassword: obscureRepeatPassword ?? this.obscureRepeatPassword,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        status,
        obscurePassword,
        obscureRepeatPassword,
        email,
        password,
      ];
}
