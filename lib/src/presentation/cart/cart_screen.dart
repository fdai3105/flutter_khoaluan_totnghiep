// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import '../../configs/configs.dart';
import '../../presentation/presentation.dart';
import '../../resources/resources.dart';
import '../../utils/utils.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const WidgetAppBar(title: 'Carts'),
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: BaseWidget<CartViewModel>(
          viewModel: CartViewModel(orderRepository: OrderRepository()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const WidgetLoading();
            }
            if (vm.carts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cart_empty.png',
                      height: 240,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Looks like you have \n havent made your choice yet...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.dark45,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: AppStyles.paddingBody,
                    itemCount: vm.carts.length,
                    itemBuilder: (context, index) {
                      final cart = vm.carts[index];
                      return Container(
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: AppStyles.radiusNormal,
                                child: cart.product.images.isEmpty
                                    ? Image.asset(
                                        'assets/images/placeholder.jpg')
                                    : CachedNetworkImage(
                                        imageUrl: AppEndpoint.domain +
                                            cart.product.images.first.image,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Image.asset(
                                              'assets/images/placeholder.jpg');
                                        },
                                        errorWidget: (context, url, err) {
                                          return Image.asset(
                                              'assets/images/placeholder.jpg');
                                        },
                                      ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.product.name,
                                        style: theme.textTheme.bodyText1,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        Formats.money(cart.product.price),
                                        style: theme.textTheme.subtitle1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      _quantityButton(
                                        icon: Icons.add_outlined,
                                        onTap: () => vm.increase(cart),
                                      ),
                                      Container(
                                        width: 40,
                                        alignment: Alignment.center,
                                        child: Text(
                                          cart.quantity.toString(),
                                          style: theme.textTheme.subtitle1,
                                        ),
                                      ),
                                      _quantityButton(
                                        icon: Icons.remove_outlined,
                                        onTap: () => vm.decrease(cart),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => vm.removeCart(cart),
                              child: Container(
                                height: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.horizontal(
                                        right:
                                            AppStyles.radiusNormal.topRight)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: const Text(
                                  'X',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Divider(color: AppColors.dark45, height: 0),
                Container(
                  color: theme.cardColor,
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${'total'.tr}: '),
                                Text(
                                  Formats.money(Maths.calTotalCart(vm.carts)),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${'items'.tr}: '),
                                Text(
                                  vm.carts.length.toString(),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => vm.checkout(),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              'check_out'.tr,
                              style:const  TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _quantityButton({IconData icon, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.dark45.withAlpha(60),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: AppColors.dark45,
          size: 20,
        ),
      ),
    );
  }
}
