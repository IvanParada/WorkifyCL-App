import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/core/themes/icon_theme.dart';
import 'package:workify_cl_app/core/themes/texts_theme.dart';
import 'package:workify_cl_app/core/validators.dart';
import 'package:workify_cl_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:workify_cl_app/features/authentication/presentation/widgets/text_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
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
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
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
                          width: 60,
                        ),
                        Center(
                          child: Text(
                            'Registrarse',
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
                    'Ingresa los datos solicitados para crear tu cuenta.',
                    style: appTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (contextCubit, stateCubit) {
                      return FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            const TextFieldWidget(
                              name: 'name',
                              labelText: 'Nombres y apellidos',
                              keyboardType: TextInputType.name,
                              validator: validateNamesAndSurnames,
                            ),
                            const SizedBox(height: 20),
                            const TextFieldWidget(
                              name: 'email',
                              labelText: 'Correo electrónico',
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                            ),
                            const SizedBox(height: 20),
                            TextFieldWidget(
                              name: 'password',
                              labelText: 'Contraseña',
                              obscureText: stateCubit.obscurePassword,
                              validator: validatePassword,
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: GestureDetector(
                                child: SvgPicture.asset(
                                  stateCubit.obscurePassword == false
                                      ? SvgAssets.eyeInvisibility
                                      : SvgAssets.eyeVisibility,
                                  fit: BoxFit.none,
                                ),
                                onTap: () {
                                  contextCubit
                                      .read<AuthenticationCubit>()
                                      .showPassword();
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFieldWidget(
                              name: 'password-repeat',
                              labelText: 'Repetir Contraseña',
                              obscureText: stateCubit.obscureRepeatPassword,
                              validator: validatePassword,
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: GestureDetector(
                                child: SvgPicture.asset(
                                  stateCubit.obscureRepeatPassword == false
                                      ? SvgAssets.eyeInvisibility
                                      : SvgAssets.eyeVisibility,
                                  fit: BoxFit.none,
                                ),
                                onTap: () {
                                  contextCubit
                                      .read<AuthenticationCubit>()
                                      .showRepeatPassword();
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            const TextFieldWidget(
                              name: 'phone',
                              labelText: 'Celular',
                              keyboardType: TextInputType.phone,
                              validator: validateChileanPhoneNumber,
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                final formState = _formKey.currentState;
                                if (formState != null) {
                                  if (formState.fields['password']!.value !=
                                      formState
                                          .fields['password-repeat']!.value) {
                                    log('contraseñas deben ser iguales');
                                  }
                                  if (formState.saveAndValidate()) {
                                    final name =
                                        formState.fields['name']?.value;
                                    final email =
                                        formState.fields['email']?.value;
                                    final password =
                                        formState.fields['password']?.value;
                                    final phone =
                                        formState.fields['phone']?.value;
                                    log('datos usuarios: (name: $name, email: $email, password: $password, phone: $phone)');
                                    context.push('/verify-signup');
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'Registrarse',
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
