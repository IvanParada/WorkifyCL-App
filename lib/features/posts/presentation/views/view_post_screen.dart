import 'package:Workify/core/enums/enums_state.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/core/themes/icon_theme.dart';
import 'package:Workify/core/themes/texts_theme.dart';
import 'package:Workify/core/util_functions.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:Workify/features/posts/presentation/widgets/btn_phone_widget.dart';
import 'package:Workify/features/posts/presentation/widgets/btn_whatsapp_widget.dart';
import 'package:Workify/features/posts/presentation/widgets/data_post_by_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ViewPostScreen extends StatelessWidget {
  ViewPostScreen({super.key});
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            width: double.infinity,
            height: 120,
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
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
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
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Publicación',
                          style: appTextTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<PostCubit, PostState>(builder: (context, state) {
            final post = state.selectedPost;
            return SingleChildScrollView(
              child: Skeletonizer(
                enabled: state.status == Status.loading,
                ignoreContainers: false,
                enableSwitchAnimation: true,
                child: Column(
                  children: [
                    Vgap(10),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.25,
                      child: PageView.builder(
                        itemCount: 3,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary.withOpacity(.5),
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://es.digitaltrends.com/wp-content/uploads/2023/12/google-chrome.jpeg?resize=1000%2C600&p=1'), // URL aleatoria
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Vgap(10),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.primary,
                        dotColor: AppColors.textPrimary.withOpacity(.5),
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DataPostById(),
                          Vgap(10),
                          Row(
                            children: [
                              const BtnWhatsapp(),
                              Hgap(20),
                              const BtnPhone()
                            ],
                          ),
                          Vgap(10),
                          const Divider(thickness: .5),
                          Vgap(10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                SvgAssets.location,
                                height: 15,
                                color: AppColors.error,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${post?.regions}, ${post?.comuna}',
                                style: appTextTheme.bodySmall,
                              ),
                            ],
                          ),
                          Vgap(10),
                          Container(
                            decoration: BoxDecoration(
                              color: post?.serviceType == 'offeredService'
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
                                serviceType(post?.serviceType),
                                style: appTextTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: .5),
                          Text(
                            'Descripción',
                            style: appTextTheme.bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${post?.description}',
                            style: appTextTheme.bodySmall!.copyWith(
                              color: AppColors.textPrimary.withOpacity(.8),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
