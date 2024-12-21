import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkTokenAndNavigate(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<void> checkTokenAndNavigate(BuildContext context) async {
    final authCubit = context.read<AuthenticationCubit>();

    try {
      final hasValidToken = await authCubit.validateToken();

      if (hasValidToken) {
        BlocProvider.of<PostCubit>(context).getRegions();
        context.go('/home');
      } else {
        context.go('/signin');
      }
    } catch (e) {
      context.go('/signin');
    }
  }

}
