import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workify_cl_app/app/routes/router.dart';
import 'package:workify_cl_app/core/networks/dio_client.dart';
import 'package:workify_cl_app/features/authentication/data/datasource/auth_datasource.dart';
import 'package:workify_cl_app/features/authentication/data/repository/auth_repository.dart';
import 'package:workify_cl_app/features/authentication/presentation/cubit/authentication_cubit.dart';

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
      ],
      child: MaterialApp.router(
        title: 'Workify',
        routerConfig: Routes.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
