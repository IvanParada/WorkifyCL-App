import 'package:Workify/core/util_functions.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';

class DataUserScreen extends StatelessWidget {
  const DataUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            width: double.infinity,
            height: 140,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: SvgPicture.asset(
                    SvgAssets.logoApp,
                    height: 80,
                    color: AppColors.textSecondary.withOpacity(0.1),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'Mis Datos',
                      style: appTextTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return Column(
                children: [
                  Vgap(30),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ],
              );
            }
          )
        ],
      ),
    );
  }
}
