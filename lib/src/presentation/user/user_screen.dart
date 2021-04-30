import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                        _avatar(context, vm),
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

  Widget _avatar(BuildContext context, UserViewModel vm) {
    var image;
    print(vm.user.user);
    if (vm.user.user.avatar != null) {
      image = Image.network(
        AppEndpoint.domain + vm.user.user.avatar,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    } else {
      image = Image.asset(
        'assets/images/placeholder.jpg',
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    }
    if (vm.avatar != null) {
      image = Image.file(
        vm.avatar,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      );
    }

    return GestureDetector(
      onTap: () async {
        final pickedFile =
            await ImagePicker().getImage(source: ImageSource.camera);
        if (pickedFile != null) {
          vm.avatar = File(pickedFile.path);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: ClipOval(child: image),
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
      ),
    );
  }
}
