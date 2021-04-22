import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../resources/resources.dart';
import '../../configs/configs.dart';
import '../../utils/utils.dart';
import '../../presentation/presentation.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartViewModel _vm;
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'Carts',
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_outlined),
            onPressed: () => _vm.clearCart(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<CartViewModel>(
          viewModel: CartViewModel(orderRepository: OrderRepository()),
          onViewModelReady: (vm) {
            _vm = vm..init();
          },
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
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
                                    : Image.network(
                                        AppEndpoint.domain +
                                            cart.product.images.first.image,
                                        fit: BoxFit.cover,
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
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        NumberFormat()
                                            .format(cart.product.price),
                                        style: const TextStyle(
                                          color: AppColors.dark45,
                                        ),
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
                                          style: const TextStyle(
                                            color: AppColors.dark45,
                                          ),
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
                GestureDetector(
                  onTap: () => vm.checkout(),
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${Maths.calTotalCart(vm.carts)} Checkout',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
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
