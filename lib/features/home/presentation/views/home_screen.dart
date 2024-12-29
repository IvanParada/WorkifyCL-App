import 'package:Workify/core/enums/enums_state.dart';
import 'package:Workify/features/posts/presentation/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:Workify/core/themes/color_theme.dart';
import 'package:Workify/features/home/presentation/widgets/card_job_widget.dart';
import 'package:Workify/features/home/presentation/widgets/custom_search_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refreshPosts(BuildContext context) async {
    context.read<PostCubit>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const CustomSearchBarWidget(),
            SizedBox(
              height: size.height * .02,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshPosts(context),
                child: BlocBuilder<PostCubit, PostState>(
                  builder: (context, state) {
                    return Skeletonizer(
                      enabled: state.status == Status.loadingRequest,
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return CardJobWidget(index: index);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
