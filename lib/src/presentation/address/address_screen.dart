import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                  title: 'address'.tr,
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
    final theme = Theme.of(context);

    if (vm.isLoading) {
      return const WidgetLoading();
    }
    if (vm.address.data.isEmpty) {
      return const Center(
        child: Text('Nothing in here, please add your address'),
      );
    }
    return WidgetIndicator(
      expanded: false,
      onRefresh: () => vm.init(),
      child: ListView.builder(
        padding: AppStyles.paddingBody,
        itemCount: vm.address.data.length,
        itemBuilder: (context, index) {
          final item = vm.address.data[index];
          return ListTile(
            // todo
            onTap: () => pushNewScreen(
              context,
              screen: EditAddressScreen(address: item),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: item.name),
                  const WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(text: item.phone),
                ],
                style: theme.textTheme.bodyText1,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.address,
                  style: theme.textTheme.subtitle1,
                ),
                Text(
                  '${item.city}, ${item.district}, ${item.ward}',
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
