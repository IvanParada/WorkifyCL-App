import 'package:flutter/material.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/features/home/presentation/widgets/card_job_widget.dart';
import 'package:workify_cl_app/features/home/presentation/widgets/custom_search_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          SingleChildScrollView(
            child: SizedBox(
              height: size.height * 0.75,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return  CardJobWidget(index: index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
