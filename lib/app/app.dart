import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workify_cl_app/app/routes/router.dart';
import 'package:workify_cl_app/features/authentication/presentation/cubit/authentication_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Workify',
        routerConfig: Routes.router, // Usa routerConfig en lugar de routerDelegate y routeInformationParser
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
