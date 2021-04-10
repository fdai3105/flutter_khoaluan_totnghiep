import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/cart/checkout/select_address/select_address.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/routers.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Cart> carts;

  const CheckoutScreen({Key key, this.carts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(
        title: 'Checkout',
      ),
      body: SafeArea(
        child: BaseWidget<CheckoutViewModel>(
          viewModel: CheckoutViewModel(addressRepository: AddressRepository()),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                _address(context, vm, vm.getSelectedAddress()),
                const SizedBox(height: 10),
                _list(),
                const SizedBox(height: 10),
                TextFormField(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _address(
      BuildContext context, CheckoutViewModel vm, AddressDatum address) {
    if (address == null) {
      return ListTile(
        onTap: () => Navigator.pushNamed(context, Routes.address),
        title: const Text('Please add your address'),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 14),
      );
    }
    return ListTile(
      onTap: () async {
        final id = await pushNewScreen(
          context,
          screen: SelectAddressScreen(selected: vm.selectedAddress),
        );
        vm.selectedAddress = id;
        await vm.init();
      },
      title: Row(
        children: const [
          Icon(Icons.delivery_dining),
          SizedBox(width: 6),
          Text('Delivery Address'),
        ],
      ),
      subtitle: Row(
        children: [
          const Icon(Icons.delivery_dining, color: Colors.transparent),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(address.address),
              Text(address.ward),
              Text('${address.district}, ${address.city}'),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.arrow_forward_ios_outlined, size: 14),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final item = carts[index];

        var image;
        if (item.product.images.isEmpty) {
          image = Image.asset(
            'assets/images/placeholder.jpg',
            height: 80,
          );
        } else {
          image = FadeInImage.assetNetwork(
            image: AppEndpoint.domain + item.product.images.first.image,
            height: 80,
            fit: BoxFit.cover,
            placeholder: 'assets/images/placeholder.jpg',
          );
        }

        return Row(
          children: [
            image,
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.product.price.toString()),
                      Text('x${item.quantity}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
