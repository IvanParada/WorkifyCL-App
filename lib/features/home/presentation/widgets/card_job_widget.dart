
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';

class CardJobWidget extends StatelessWidget {
  const CardJobWidget({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .05,
        vertical: size.height * .01,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.textSecondary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre del trabajo, titulo',
                      style: appTextTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgAssets.dolar,
                          height: 15,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '10.000 CLP por hora',
                          style: appTextTheme.bodySmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgAssets.location,
                          height: 15,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Santa Juana, VII Región',
                          style: appTextTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        child: Text(
                          'Servicio Ofrecido',
                          style: appTextTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  SvgAssets.arrowRight,
                  height: 20,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
