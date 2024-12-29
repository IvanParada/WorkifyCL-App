import 'package:Workify/features/authentication/presentation/views/recovery_screen.dart';
import 'package:Workify/features/authentication/presentation/views/recovery_step2_screen.dart';
import 'package:Workify/features/authentication/presentation/views/recovery_step3_screen.dart';
import 'package:Workify/features/authentication/presentation/views/signin_screen.dart';
import 'package:Workify/features/authentication/presentation/views/signup_screen.dart';
import 'package:Workify/features/authentication/presentation/views/signup_step2_screen.dart';
import 'package:Workify/features/home/presentation/views/home_screen.dart';
import 'package:Workify/features/home/presentation/views/splash_screen.dart';
import 'package:Workify/features/main_screen.dart';
import 'package:Workify/features/posts/presentation/views/add_post_screen.dart';
import 'package:Workify/features/posts/presentation/views/view_post_screen.dart';
import 'package:Workify/features/profile/presentation/view/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
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
      path: '/signup-step-2',
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

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/add-post',
          builder: (context, state) => const AddPostScreen(),
        ),
        GoRoute(
          path: '/view-post',
          builder: (context, state) =>  ViewPostScreen(),
        ),
      ],
    ),
  ],
);

class Routes {
  static GoRouter get router => _router;
}
