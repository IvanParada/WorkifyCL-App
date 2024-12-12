import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/core/themes/icon_theme.dart';
import 'package:workify_cl_app/core/themes/texts_theme.dart';
import 'package:workify_cl_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:workify_cl_app/features/authentication/presentation/widgets/auto_focus_widget.dart';

class SignUpVerifyScreen extends StatelessWidget {
  SignUpVerifyScreen({super.key});
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              width: double.infinity,
              height: 200.0,
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
                    padding: const EdgeInsets.only(top: 50, left: 30),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: SvgPicture.asset(
                            SvgAssets.arrowLeft,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Center(
                          child: Text(
                            'Verificar',
                            style: appTextTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingresa el código de verificación que se ha enviado a tu correo electrónico.',
                    style: appTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (contextCubit, stateCubit) {
                      final List<FocusNode> focusNodes =
                          List.generate(6, (_) => FocusNode());
                      final List<TextEditingController> controllers =
                          List.generate(6, (_) => TextEditingController());

                      return FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(6, (index) {
                                return AutoFocusTextField(
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  nextFocusNode:
                                      index < 5 ? focusNodes[index + 1] : null,
                                  onChanged: (value) {
                                    // Optional: handle changes
                                  },
                                );
                              }),
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                final formState = _formKey.currentState;
                                final code =
                                    controllers.map((c) => c.text).join();

                                if (formState != null && code.length == 6) {
                                  log('código de verificacion: $code');
                                  context.push('/');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Verificar',
                                    style: appTextTheme.bodyMedium!.copyWith(
                                        color: AppColors.textSecondary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
