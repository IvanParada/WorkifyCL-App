import 'package:Workify/app/routes/router.dart';
import 'package:Workify/core/networks/dio_client.dart';
import 'package:Workify/features/authentication/data/datasource/auth_datasource.dart';
import 'package:Workify/features/authentication/data/repository/auth_repository.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:Workify/features/posts/data/datasource/post_datasource.dart';
import 'package:Workify/features/posts/data/repository/post_repository.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(
            const FlutterSecureStorage(),
            authRepository: AuthRepository(
              authDatasource: AuthDatasource(
                dio: DioClient.dio,
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PostCubit(
            postRepository: PostRepository(
              postDatasource: PostDatasource(
                dio: DioClient.dio,
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Workify',
        routerConfig: Routes.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // ignore: deprecated_member_use
              textScaler: TextScaler.linear(MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2)),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
