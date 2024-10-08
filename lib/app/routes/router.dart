import 'package:go_router/go_router.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/recovery_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/recovery_step2_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/recovery_step3_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/signin_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/signup_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/signup_step2_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/signin',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/verify-signup',
      builder: (context, state) => SignUpVerifyScreen(),
    ),
    GoRoute(
      path: '/recovery',
      builder: (context, state) => RecoveryScreen(),
    ),
    GoRoute(
      path: '/recovery-step-2',
      builder: (context, state) => RecoveryStep2Screen(),
    ),
    GoRoute(
      path: '/recovery-step-3',
      builder: (context, state) => RecoveryStep3Screen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => SignInScreen(),
    ),
  ],
);

class Routes {
  static GoRouter get router => _router;
}
