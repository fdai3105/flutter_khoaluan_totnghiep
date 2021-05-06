import 'package:flutter/material.dart';
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
                  title: 'New address',
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
                  title: const Text('City'),
                  trailing: vm.city == null
                      ? const Text(
                          'Set city',
                          style: TextStyle(color: AppColors.dark45),
                        )
                      : Text(vm.cityName),
                ),
                ListTile(
                  onTap: () async => vm.onDistrictSelected(),
                  contentPadding: AppStyles.paddingBody,
                  title: const Text('District'),
                  trailing: vm.districtName == null
                      ? const Text(
                          'Set district',
                          style: TextStyle(color: AppColors.dark45),
                        )
                      : Text(vm.districtName),
                ),
                ListTile(
                  onTap: () => vm.onWardSelected(),
                  contentPadding: AppStyles.paddingBody,
                  title: const Text('Ward'),
                  trailing: vm.wardName == null
                      ? const Text(
                          'Set ward',
                          style: TextStyle(color: AppColors.dark45),
                        )
                      : Text(vm.wardName),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  onChanged: (value) => vm.address = value,
                  hint: 'Address',
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  onChanged: (value) => vm.name = value,
                  hint: 'Name',
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  onChanged: (value) => vm.phone = value,
                  hint: 'Phone',
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
