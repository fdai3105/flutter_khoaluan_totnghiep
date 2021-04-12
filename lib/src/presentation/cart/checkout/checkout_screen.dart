import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../utils/utils.dart';
import '../../../configs/configs.dart';
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
          viewModel: CheckoutViewModel(
            orderRepository: OrderRepository(),
            addressRepository: AddressRepository(),
          ),
          onViewModelReady: (vm) async {
            await vm.init();
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _address(context, vm, vm.getSelectedAddress()),
                        const SizedBox(height: 10),
                        _list(),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.dark45.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextFormField(
                            onChanged: (value) => vm.note = value,
                            cursorColor: AppColors.dark,
                            decoration: const InputDecoration(
                              hintText: 'Note',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            const Divider(color: AppColors.dark45),
                            ListTile(
                              title: const Text('Merchandise subtotal()'),
                              trailing:
                                  Text(Maths.calTotalCart(carts).toString()),
                            ),
                            const ListTile(
                              title: Text('Shipping fee'),
                              trailing: Text('22.600'),
                            ),
                            ListTile(
                              title: const Text('Order amount'),
                              trailing:
                                  Text(Maths.calTotalCart(carts).toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: AppColors.dark45, height: 0),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Total Payment'),
                          Text(
                            Maths.calTotalCart(carts).toString(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => vm.checkout(),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        elevation: 0,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Place order'),
                    ),
                  ],
                ),
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
        onTap: () => Navigator.pushNamed(context, Routes.address)
            .then((value) => vm.init()),
        title: const Text('Please add your address'),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 14),
      );
    }
    return ListTile(
      onTap: () async {
        final id = await pushNewScreen(
          context,
          screen: SelectAddressScreen(selected: vm.selectedAddress),
        ).then((value) => vm.init());
        vm.selectedAddress = id;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.dark45),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Products'),
        ),
        const SizedBox(height: 4),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: carts.length,
          itemBuilder: (context, index) {
            final item = carts[index];

            var image;
            if (item.product.images.isEmpty) {
              image = Image.asset(
                'assets/images/placeholder.jpg',
                height: 80,
                width: 80,
              );
            } else {
              image = FadeInImage.assetNetwork(
                image: AppEndpoint.domain + item.product.images.first.image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                placeholder: 'assets/images/placeholder.jpg',
              );
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
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
              ),
            );
          },
        ),
        const Divider(color: AppColors.dark45),
      ],
    );
  }
}
