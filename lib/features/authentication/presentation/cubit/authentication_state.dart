part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final Status? status;
  final bool obscurePassword;
  final bool obscureRepeatPassword;
  final String? email;
  final String? password;
  final bool? verifyMessage;
  final LoginResponseModel? loginUserData;
  final SignUpResponseModel? signupUserData;
  final RequestResetPasswordModel? codeRequestResetPass;
  final String? setCodeResetPass;
  final String? setEmailResetPass;

  const AuthenticationState({
    this.status,
    this.codeRequestResetPass,
    this.verifyMessage = false,
    this.obscurePassword = true,
    this.obscureRepeatPassword = true,
    this.email,
    this.password,
    this.loginUserData,
    this.signupUserData,
    this.setCodeResetPass,
    this.setEmailResetPass,
  });

  AuthenticationState copyWith({
    Status? status,
    bool? verifyMessage,
    bool? obscurePassword,
    bool? obscureRepeatPassword,
    String? email,
    String? password,
    LoginResponseModel? loginUserData,
    SignUpResponseModel? signupUserData,
    RequestResetPasswordModel? codeRequestResetPass,
    String? setCodeResetPass,
    String? setEmailResetPass,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      codeRequestResetPass: codeRequestResetPass ?? this.codeRequestResetPass,
      verifyMessage: verifyMessage ?? this.verifyMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureRepeatPassword:
          obscureRepeatPassword ?? this.obscureRepeatPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      loginUserData: loginUserData ?? this.loginUserData,
      signupUserData: signupUserData ?? this.signupUserData,
      setCodeResetPass: setCodeResetPass ?? this.setCodeResetPass,
      setEmailResetPass: setEmailResetPass ?? this.setEmailResetPass,
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
        signupUserData,
        verifyMessage,
        codeRequestResetPass,
        setCodeResetPass,
        setEmailResetPass,
      ];
}
