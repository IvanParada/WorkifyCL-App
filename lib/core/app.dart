import 'package:flutter/material.dart';
import 'package:workify_cl_app/features/authentication/presentation/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Workify',
      home: LoginScreen(),
    );
  }
}