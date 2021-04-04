import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/user/address/add_address/add_address_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../resources/repositories/address.dart';
import '../../presentation.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WidgetAppBar(
        title: 'Add address',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_outlined),
            onPressed: () {
              pushNewScreen(
                context,
                screen: AddAddressScreen(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BaseWidget<AddressViewModel>(
          viewModel: AddressViewModel(addressRepository: AddressRepository()),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () async {
                await vm.init();
              },
              child: ListView.builder(
                itemCount: vm.address.data.length,
                itemBuilder: (context, index) {
                  final item = vm.address.data[index];
                  return ListTile(
                    title: Text(item.address),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.ward),
                        Text(item.district),
                        Text(item.city),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
