import 'package:Workify/core/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:Workify/features/profile/presentation/widgets/profile_option_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: <Widget>[
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
                      'Perfil',
                      style: appTextTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Vgap(20),
           ProfileOptionWidget(
            title: 'Mis Datos',
            icon: SvgAssets.user,
            onTap: () => context.push('/my-data'),
          ),
          //TODO: Hacer vista de mis publicaciones para visualizar/eliminar/editar
           ProfileOptionWidget(
            title: 'Mis Publicaciones',
            icon: SvgAssets.list,
            onTap: () => context.push('/home'),

          ),
          SizedBox(
            height: size.height * 0.3,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthenticationCubit>(context).logOut();
              context.push('/signin');
            },
            child: Container(
              height: size.height * 0.05,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Cerrar sesión',
                  style: appTextTheme.bodyMedium!.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
