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
      return WidgetLoading();
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
          return ListTile(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: item.name),
                  const WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(text: item.phone),
                ],
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.address),
                Text('${item.city}, ${item.district}, ${item.ward}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
