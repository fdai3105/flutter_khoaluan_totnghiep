import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class AddAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: BaseWidget<AddAddressViewModel>(
          viewModel:
              AddAddressViewModel(addressRepository: AddressRepository()),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, widget) {
            return Column(
              children: [
                WidgetAppBar(
                  title: 'new_address'.tr,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.check_outlined),
                      onPressed: () => vm.addAddress(),
                    )
                  ],
                ),
                ListTile(
                  onTap: () => vm.onCitySelected(),
                  contentPadding: AppStyles.paddingBody,
                  title: Text('city'.tr),
                  trailing: vm.city == null
                      ? Text(
                          'set_city'.tr,
                          style: const TextStyle(color: AppColors.dark45),
                        )
                      : Text(vm.cityName),
                ),
                ListTile(
                  onTap: () async => vm.onDistrictSelected(),
                  contentPadding: AppStyles.paddingBody,
                  title: Text('district'.tr),
                  trailing: vm.districtName == null
                      ? Text(
                          'set_district'.tr,
                          style: const TextStyle(color: AppColors.dark45),
                        )
                      : Text(vm.districtName),
                ),
                ListTile(
                  onTap: () => vm.onWardSelected(),
                  contentPadding: AppStyles.paddingBody,
                  title: Text('ward'.tr),
                  trailing: vm.wardName == null
                      ? Text(
                          'set_ward'.tr,
                          style: const TextStyle(color: AppColors.dark45),
                        )
                      : Text(vm.wardName),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  onChanged: (value) => vm.address = value,
                  hint: 'address'.tr,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  onChanged: (value) => vm.name = value,
                  hint: 'name'.tr,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  onChanged: (value) => vm.phone = value,
                  hint: 'register_phone'.tr,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
