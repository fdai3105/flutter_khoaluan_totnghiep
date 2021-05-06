import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class EditAddressScreen extends StatelessWidget {
  final AddressDatum address;

  const EditAddressScreen({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<EditAddressViewModel>(
          viewModel:
              EditAddressViewModel(addressRepository: AddressRepository()),
          onViewModelReady: (vm) async {
            await vm.init(address);
          },
          builder: (context, vm, widget) {
            return Column(
              children: [
                WidgetAppBar(
                  title: 'Edit address',
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
                  trailing: address.city != null
                      ? Text(address.city)
                      : vm.city == null
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
                  trailing: address.district != null
                      ? Text(address.district)
                      : vm.districtName == null
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
                  trailing: address.ward != null
                      ? Text(address.ward)
                      : vm.wardName == null
                          ? const Text(
                              'Set ward',
                              style: TextStyle(color: AppColors.dark45),
                            )
                          : Text(vm.wardName),
                ),
                WidgetInput(
                  onChanged: (value) => vm.address = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => vm.deleteAddress(address.id),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Remove address'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
