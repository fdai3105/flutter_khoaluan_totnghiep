import 'package:flutter/material.dart';
import '../../../../resources/models/models.dart';
import '../../../../utils/routers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../../resources/models/city.dart';
import '../../../../resources/models/district.dart';
import '../../../../resources/repositories/address.dart';
import '../../../presentation.dart';
import 'district/district_screen.dart';
import 'ward/ward_screen.dart';

class AddAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var city;
    var district;
    var ward;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<AddressViewModel>(
          viewModel: AddressViewModel(addressRepository: AddressRepository()),
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
                      icon: const Icon(Icons.add_outlined),
                      onPressed: () {},
                    )
                  ],
                ),
                ListTile(
                  onTap: () async {
                    city = await Navigator.pushNamed(context, Routes.city);
                    vm.city = city.name;
                  },
                  title: const Text('City'),
                  trailing: Text(vm.city ?? ''),
                ),
                ListTile(
                  onTap: () async {
                    if (city == null) return;
                    district = await pushNewScreen(
                      context,
                      screen: DistrictScreen(cityID: city.code),
                    );
                    vm.district = district.name;
                  },
                  title: const Text('District'),
                  trailing: Text(vm.district ?? ''),
                ),
                ListTile(
                  onTap: () async {
                    if (district == null) return;
                    ward = await pushNewScreen(
                      context,
                      screen: WardScreen(districtID: district.code),
                    );
                    vm.ward = ward.name;
                  },
                  title: const Text('Ward'),
                  trailing: Text(vm.ward ?? ''),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
