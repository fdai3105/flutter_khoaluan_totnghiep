import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../utils/utils.dart';
import '../../../configs/configs.dart';
import '../../presentation.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BaseWidget<UserTabViewModel>(
        viewModel: UserTabViewModel(),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, widget) {
          return Column(
            children: [
              const WidgetAppBar(title: 'User', centerTitle: false),
              const SizedBox(height: 20),
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
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: _user(context, vm),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              WidgetTile(
                onTap: () => pushNewScreen(
                  context,
                  screen: FavoriteScreen(),
                  withNavBar: false,
                ),
                title: 'My favorites',
              ),
              WidgetTile(
                onTap: () => pushNewScreen(
                  context,
                  screen: SharedPref.getUser() == null
                      ? LoginScreen()
                      : OrderScreen(),
                  withNavBar: false,
                ),
                title: 'My orders',
              ),
              WidgetTile(
                title: 'Address',
                onTap: () => pushNewScreen(
                  context,
                  screen: SharedPref.getUser() == null
                      ? LoginScreen()
                      : AddressScreen(),
                  withNavBar: false,
                ),
              ),
              const WidgetTile(
                title: 'Feedback',
              ),
              const WidgetTile(
                title: 'Customer Support',
              ),
              const WidgetTile(
                title: 'About the app',
              ),
              if (vm.user != null)
                WidgetTile(
                  title: 'Logout',
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
    if (vm.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (vm.user == null) {
      return Row(
        children: [
          ClipOval(child: Image.asset('assets/images/placeholder.jpg')),
          const SizedBox(width: 10),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        if (vm.user.user.avatar == null)
          ClipOval(
            child: Image.asset('assets/images/placeholder.jpg'),
          )
        else
          ClipOval(
            child: Image.asset('assets/images/placeholder.jpg'),
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
              const Text(
                'edit you profile',
                style: TextStyle(
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
