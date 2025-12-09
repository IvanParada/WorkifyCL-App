import 'dart:developer';

import 'package:Workify/core/util_functions.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:Workify/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:go_router/go_router.dart';

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
            height: 120,
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
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(
                          SvgAssets.arrowLeft,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Mis Datos',
                          style: appTextTheme.bodyLarge,
                        ),
                      ),
                    ],
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
                GestureDetector(
                  onTap: () {
                    log('TODO: AGREGAR FUNCIONALIDAD DE SUBIR IMAGEN');
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        SvgAssets.wProfile,
                        scale: .5,
                      ),
                      Positioned(
                        top: size.height * .11,
                        right: -20,
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                SvgAssets.edit,
                                color: AppColors.primary,
                                height: 25,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Vgap(10),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .05,
                      vertical: size.height * .02),
                  child: IgnorePointer(
                    ignoring: true,
                    child: Column(
                      spacing: size.height * .03,
                      children: const [
                        TextFieldWidget(
                          labelText: 'John Doe',
                          name: 'John Doe',
                        ),
                        TextFieldWidget(
                          labelText: 'correo@example.com',
                          name: 'correo@example.com',
                        ),
                        TextFieldWidget(
                          labelText: '+56 9 1122 3344',
                          name: '+56 9 1122 3344',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
