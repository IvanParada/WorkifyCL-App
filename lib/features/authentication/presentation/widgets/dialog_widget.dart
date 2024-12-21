import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    required this.message,
    required this.title,
    super.key,
    this.icon,
    this.colorTypeDialog,
    this.onTap,
    this.btnText,
  });

  final String? icon;
  final String title;
  final String message;
  final String? btnText;
  final Color? colorTypeDialog;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.37,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: colorTypeDialog?.withOpacity(.5) ??
                      AppColors.success.withOpacity(.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: colorTypeDialog ?? AppColors.success,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          icon ?? SvgAssets.check,
                          height: 20,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: appTextTheme.bodyLarge!.copyWith(
                  color: colorTypeDialog ?? AppColors.success,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  message,
                  style: appTextTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: onTap ?? () => context.pop(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 40,
                  decoration: BoxDecoration(
                      color: colorTypeDialog ?? AppColors.success,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      btnText ?? 'Aceptar',
                      style: appTextTheme.bodyMedium!
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void showCustomAnimatedDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? icon,
  String? btnText,
  Color? colorTypeDialog,
  void Function()? onTap,
}) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black54, 
    barrierDismissible: true, 
    barrierLabel: 'Dismiss',
    pageBuilder: (context, animation1, animation2) {
      return Container(); 
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(
            parent: animation1,
            curve: Curves.easeInOut,
          ),
        ),
        child: DialogWidget(
          title: title,
          message: message,
          icon: icon,
          btnText: btnText,
          colorTypeDialog: colorTypeDialog,
          onTap: onTap,
        ),
      );
    },
  );
}
