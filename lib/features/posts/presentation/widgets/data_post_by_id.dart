import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/core/util_functions.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class DataPostById extends StatelessWidget {
  const DataPostById({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      final post = state.selectedPost;
      return Row(
        children: [
          Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: size.width * .65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post?.title}',
                  textAlign: TextAlign.start,
                  style: appTextTheme.titleLarge!.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                      priceFormatted(post?.price.toString()),
                      style: appTextTheme.bodyMedium,
                    ),
                  ],
                ),
                const RatingBar.readOnly(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  initialRating: 3.5,
                  isHalfAllowed: true,
                  halfFilledIcon: Icons.star_half,
                  maxRating: 5,
                  size: 25,
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
