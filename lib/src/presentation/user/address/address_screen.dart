import 'package:flutter/material.dart';
import '../../../configs/configs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../resources/repositories/repositories.dart';
import '../../presentation.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  title: 'Address',
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.add_outlined),
                      onPressed: () => vm.toAddAddress(),
                    ),
                  ],
                ),
                Expanded(child: _body(context, vm)),
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
    if (vm.address.data.isEmpty) {
      return const Center(
        child: Text('Nothing in here, please add your address'),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        await vm.init();
      },
      child: ListView.builder(
        padding: AppStyles.paddingBody,
        itemCount: vm.address.data.length,
        itemBuilder: (context, index) {
          final item = vm.address.data[index];
          return GestureDetector(
            onTap: () => pushNewScreen(
              context,
              screen: EditAddressScreen(address: item),
            ).then((value) => vm.init()),
            behavior: HitTestBehavior.translucent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/address.png', height: 30),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.phone,
                          style: const TextStyle(color: AppColors.dark45),
                        ),
                      ],
                    ),
                    Text(
                      item.address,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      '${item.city}, ${item.district}, ${item.ward}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
