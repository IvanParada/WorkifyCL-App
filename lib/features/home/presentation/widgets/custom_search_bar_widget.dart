import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/core/themes/icon_theme.dart';

class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(20)),
            height: size.height * .05,
            width: size.width * .7,
            child: SearchBar(
              elevation: WidgetStateProperty.resolveWith((states) => 0),
              backgroundColor: WidgetStateColor.resolveWith(
                (states) {
                  if (states.contains(WidgetState.focused)) {
                    return AppColors.textSecondary;
                  }
                  return AppColors.textSecondary.withOpacity(0.3);
                },
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  SvgAssets.search,
                  color: AppColors.primary,
                ),
              ),
              hintText: 'Buscar...',
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset(
                SvgAssets.filter,
                color: AppColors.textSecondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}