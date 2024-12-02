import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:workify_cl_app/core/themes/color_theme.dart';
import 'package:workify_cl_app/features/home/presentation/views/home_screen.dart';
import 'package:workify_cl_app/features/posts/presentation/cubit/post_cubit.dart';
import 'package:workify_cl_app/features/profile/presentation/view/profile_screen.dart';
import 'package:workify_cl_app/features/posts/presentation/views/add_post_screen.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const AddPostScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: SlidingClippedNavBar(
          backgroundColor: AppColors.primary,
          onButtonPressed: (index) {
            setState(() {
              
              selectedIndex = index;
            });
          },
          activeColor: AppColors.textSecondary,
          inactiveColor: AppColors.textSecondary,
          selectedIndex: selectedIndex,
          iconSize: 25,
          barItems: [
            BarItem(
              icon: Icons.home,
              title: 'Inicio',
            ),
            BarItem(
              icon: Icons.add,
              title: 'Publicar',
            ),
            BarItem(
              icon: Icons.person_outline_outlined,
              title: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
