
import 'package:Workify/core/enums/enums_state.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/core/validators.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:Workify/features/authentication/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        'Iniciar sesión',
                        style: appTextTheme.bodyLarge,
                      ),
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
                    'Ingresa tus credenciales para ingresar a la aplicación.',
                    style: appTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  BlocListener<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state.status == Status.successLogin) {
                        GoRouter.of(context).go('/home');
                      } else if (state.status == Status.failureLogin) {
                        showCustomAnimatedDialog(
                          context: context,
                          title: 'Verifica tus datos',
                          message:
                              'Verifica que las credenciales ingresadas sean correctas.',
                          colorTypeDialog: AppColors.error,
                          icon: SvgAssets.close,
                          onTap: () {
                            Navigator.of(context).pop();
                            GoRouter.of(context).go('/signin');
                          },
                        );
                      }
                    },
                    child:
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
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => context.push('/recovery'),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '¿Has olvidado tu contraseña? ',
                                        style: appTextTheme.bodyMedium,
                                      ),
                                      TextSpan(
                                        text: 'Recuperar',
                                        style:
                                            appTextTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.info,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100),
                              GestureDetector(
                                onTap: () {
                                  final formState = _formKey.currentState;

                                  if (formState != null &&
                                      formState.saveAndValidate()) {
                                    final email =
                                        formState.fields['email']?.value;
                                    final password =
                                        formState.fields['password']?.value;

                                    contextCubit
                                        .read<AuthenticationCubit>()
                                        .logIn(email, password);
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Iniciar sesión',
                                      style: appTextTheme.bodyMedium!.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            GestureDetector(
              onTap: () => context.push('/signup'),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '¿Aún no tienes cuenta? ',
                        style: appTextTheme.bodyMedium),
                    TextSpan(
                      text: 'Registrarse',
                      style: appTextTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: AppColors.info),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
