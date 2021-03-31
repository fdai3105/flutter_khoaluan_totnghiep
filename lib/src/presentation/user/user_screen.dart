import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/base/base.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/presentation.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: SafeArea(
        child: BaseWidget<UserViewModel>(
          viewModel: UserViewModel(),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final user = vm.user.user;
            return Padding(
              padding: AppStyles.paddingBody,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _avatar(context),
                  const SizedBox(height: 30),
                  WidgetInput(
                    hint: 'Name',
                    value: user.name,
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
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'User',
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.grey),
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
      ],
    );
  }
}
