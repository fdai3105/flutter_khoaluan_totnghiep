import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/constants/constants.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/base/base.dart';
import 'home.dart';
import '../../resources/repositories/auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<HomeViewModel>(
          viewModel: HomeViewModel(
            authRepository: AuthRepository(),
          ),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, child) {
            return _mobile(context, vm);
          },
        ),
      ),
    );
  }

  Widget _mobile(BuildContext context, HomeViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _appbar(vm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Best Furnitute\nin your home.',
                style: TextStyle(
                  color: AppColors.textDark.withOpacity(0.7),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _search(context, vm),
              const SizedBox(height: 20),
              _popularProduct(context, vm),
            ],
          ),
        )
      ],
    );
  }

  Widget _appbar(HomeViewModel vm) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: vm.user == null
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset('assets/images/placeholder.jpg'),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    vm.user.user.avatar ?? 'assets/images/placeholder.jpg',
                  ),
                ),
              ),
            ),
    );
  }

  Widget _search(BuildContext context, HomeViewModel vm) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppStyles.radiusNormal,
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: AppStyles.radiusNormal,
            ),
            child: Icon(
              Icons.search_rounded,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _popularProduct(BuildContext context, HomeViewModel vm) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Sell all',
                style: TextStyle(
                  color: AppColors.hintDark,
                ),
              ),
            )
          ],
        ),
        if (vm.popular == null)
          const CircularProgressIndicator()
        else
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: vm.popular.data.length,
              itemBuilder: (context, index) {
                final product = vm.popular.data[index];
                return Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : 10,
                      right: 10,
                      bottom: 10,
                      top: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (product.images.isEmpty)
                          Image.asset(
                            'assets/images/placeholder.jpg',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        else
                          Image.network(
                            AppEndpoint.domain + product.images.first.image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        Text(
                          product.name ?? "",
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text('${product.price} vnd'),
                      ],
                    ));
              },
            ),
          )
      ],
    );
  }
}
