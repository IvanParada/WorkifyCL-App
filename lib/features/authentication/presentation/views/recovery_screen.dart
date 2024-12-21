import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/core/validators.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:Workify/features/authentication/presentation/widgets/text_field_widget.dart';

class RecoveryScreen extends StatelessWidget {
  RecoveryScreen({super.key});
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
                      colorFilter: ColorFilter.mode(
                        AppColors.textSecondary.withOpacity(0.1),
                        BlendMode.srcIn,
                      ),
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
                            colorFilter: const ColorFilter.mode(
                              AppColors.textSecondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: Text(
                            'Recuperar cuenta',
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
                    'Ingresa tu correo electrónico para solicitar el código de seguirdad y cambiar tu contraseña.',
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
                              name: 'email',
                              labelText: 'Correo electrónico',
                              obscureText: false,
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 100),
                            GestureDetector(
                              onTap: () {
                                final formState = _formKey.currentState;

                                if (formState != null &&
                                    formState.saveAndValidate()) {
                                  final email =
                                      formState.fields['email']?.value;

                                  context
                                      .read<AuthenticationCubit>()
                                      .requestResetPassword(email, context);
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
                                    'Solicitar',
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
