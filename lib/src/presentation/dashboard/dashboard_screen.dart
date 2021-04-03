import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../presentation.dart';

class DashboardScreen extends StatelessWidget {
  final _screens = [HomeTab(), CategoryTab(), UserTab()];
  final _items = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      title: "Home",
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.category_outlined),
      title: "Category",
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person),
      title: "User",
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          context,
          screens: _screens,
          items: _items,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style12,
        ),
      ),
    );
  }
}
