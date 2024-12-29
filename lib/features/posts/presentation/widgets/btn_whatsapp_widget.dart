import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BtnWhatsapp extends StatelessWidget {
  const BtnWhatsapp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          color: AppColors.whatsapp.withOpacity(.2),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          SvgAssets.wsp,
          colorFilter: const ColorFilter.mode(
            AppColors.whatsapp,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
