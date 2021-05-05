import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../utils/routers.dart';
import '../../configs/configs.dart';
import '../presentation.dart';

class DashboardScreen extends StatelessWidget {
  final _screens = [HomeTab(), CategoryTab(), UserTab()];
  final _items = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_outlined),
      title: "Home",
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: Colors.grey,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: Routes.routes,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.category_outlined),
      title: "Category",
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: Routes.routes,
      ),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person),
      title: "User",
      activeColorPrimary: AppColors.primary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/',
        routes: Routes.routes,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          context,
          screens: _screens,
          items: _items,
          backgroundColor: theme.backgroundColor,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style12,
        ),
      ),
    );
  }
}
