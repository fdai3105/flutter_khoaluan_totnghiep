import 'package:flutter/material.dart';
import '../../resources/repositories/auth.dart';
import '../../configs/configs.dart';
import '../presentation.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name;
    int gender;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<UserViewModel>(
          viewModel: UserViewModel(authRepository: AuthRepository()),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final user = vm.user.user;
            return Column(
              children: [
                WidgetAppBar(
                  title: 'User',
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.check_outlined),
                      onPressed: () {
                        vm.submit(name, gender);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: AppStyles.paddingBody,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        _avatar(context),
                        const SizedBox(height: 30),
                        WidgetInput(
                          hint: 'Name',
                          value: user.name,
                          onChanged: (value) => name = value,
                        ),
                        const SizedBox(height: 20),
                        WidgetInput(
                          hint: 'Email',
                          value: user.email,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        WidgetInput(
                          hint: 'Phone number',
                          value: user.phone,
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/placeholder.jpg',
            height: 100,
            width: 100,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
