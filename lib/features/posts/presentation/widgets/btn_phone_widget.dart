import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BtnPhone extends StatelessWidget {
  const BtnPhone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(.2),
          borderRadius: BorderRadius.circular(5)),
           child: Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          SvgAssets.phone,
          colorFilter: const ColorFilter.mode(
            AppColors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
