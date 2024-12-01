import 'package:go_router/go_router.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/recovery_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/recovery_step2_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/recovery_step3_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/signin_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/signup_screen.dart';
import 'package:workify_cl_app/features/authentication/presentation/views/signup_step2_screen.dart';
import 'package:workify_cl_app/features/home/presentation/views/home_screen.dart';
import 'package:workify_cl_app/features/home/presentation/views/splash_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
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
  ],
);

class Routes {
  static GoRouter get router => _router;
}
