import 'package:Workify/core/util_functions.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CardJobWidget extends StatelessWidget {
  const CardJobWidget({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      final publication = state.posts[index];
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .05,
          vertical: size.height * .01,
        ),
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<PostCubit>(context).getPostsById(publication.id);
            context.push('/view-post');
          },
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
              padding: const EdgeInsets.all(10),
              child: Row(
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
                  const SizedBox(width: 20),
                  SizedBox(
                    width: size.width * .55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          publication.title,
                          overflow: TextOverflow.ellipsis,
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
                              priceFormatted(publication.price.toString()),
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
                            SizedBox(
                              width: size.width * .48,
                              child: Text(
                                '${publication.regions}, ${publication.comuna}',
                                style: appTextTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Vgap(5),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    publication.serviceType == 'offeredService'
                                        ? AppColors.success.withOpacity(.4)
                                        : AppColors.info.withOpacity(.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 2,
                                ),
                                child: Text(
                                  serviceType(publication.serviceType),
                                  style: appTextTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(publication.createdAt),
                              style: appTextTheme.bodySmall!.copyWith(
                                color: AppColors.textPrimary.withOpacity(.5),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
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
    });
  }
}
