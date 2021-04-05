import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../resources/repositories/repositories.dart';
import '../../presentation.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: WidgetAppBar(
      //   title: 'Address',
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.add_outlined),
      //       onPressed: () {
      //         pushNewScreen(
      //           context,
      //           screen: AddAddressScreen(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
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
                  title: 'Address',
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.add_outlined),
                      onPressed: () {
                        pushNewScreen(
                          context,
                          screen: AddAddressScreen(),
                        ).then((value) => vm.init());
                      },
                    ),
                  ],
                ),
                _body(context, vm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, AddressViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await vm.init();
        },
        child: ListView.builder(
          itemCount: vm.address.data.length,
          itemBuilder: (context, index) {
            final item = vm.address.data[index];
            return ListTile(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: EditAddressScreen(address: item),
                ).then((value) => vm.init());
              },
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
      ),
    );
  }
}
