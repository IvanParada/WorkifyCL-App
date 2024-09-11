import 'package:flutter/material.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            color: AppColors.secondary,
            child: const Center(
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 24.0,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingresa tus credenciales para ingresar a la aplicación',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Texto 2',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
