import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/configs.dart';
import '../../../utils/utils.dart';
import '../../presentation.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.backgroundColor,
      child: BaseWidget<UserTabViewModel>(
        viewModel: UserTabViewModel(),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, widget) {
          return Column(
            children: [
              WidgetAppBar(title: 'user'.tr, centerTitle: false),
              const SizedBox(height: 14),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: vm.user == null ? LoginScreen() : UserScreen(),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: _user(context, vm),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              WidgetTile(
                onTap: () => pushNewScreen(
                  context,
                  screen: FavoriteScreen(),
                  withNavBar: false,
                ),
                title: 'favorite'.tr,
              ),
              WidgetTile(
                onTap: () => pushNewScreen(
                  context,
                  screen: SharedPref.getUser() == null
                      ? LoginScreen()
                      : OrderScreen(),
                  withNavBar: false,
                ),
                title: 'order'.tr,
              ),
              WidgetTile(
                title: 'address'.tr,
                onTap: () => pushNewScreen(
                  context,
                  screen: SharedPref.getUser() == null
                      ? LoginScreen()
                      : AddressScreen(),
                  withNavBar: false,
                ),
              ),
              WidgetTile(
                title: 'setting'.tr,
                onTap: () => pushNewScreen(
                  context,
                  screen: SettingScreen(),
                  withNavBar: false,
                ),
              ),
              WidgetTile(title: 'about'.tr),
              if (vm.user != null)
                WidgetTile(
                  title: 'logout'.tr,
                  onTap: () {
                    vm.logout();
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _user(BuildContext context, UserTabViewModel vm) {
    if (vm.user == null) {
      return Row(
        children: [
          Container(
            height: 60,
            width: 60,
            child: ClipOval(
              child: Image.asset('assets/images/placeholder.jpg'),
            ),
          ),
          const SizedBox(width: 10),
           Text(
            'login'.tr,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          WidgetAvatar(
            size: 60,
            image: vm.user.user.avatar,
          ),
          const SizedBox(width: 10),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hi, ${vm.user.user.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                 Text(
                  'edit_you_profile'.tr,
                  style:const TextStyle(
                    color: AppColors.dark45,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_outlined, size: 14),
        ],
      );
    }
  }
}
