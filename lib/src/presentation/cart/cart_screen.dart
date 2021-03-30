import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../configs/configs.dart';
import '../../utils/utils.dart';
import '../../presentation/presentation.dart';

class CartScreen extends StatelessWidget {
  Widget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Carts',
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.grey),
      actions: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            SharedPref.removeCarts();
          },
        )
      ],
    );
  }

  Widget _quantityButton({IconData icon, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.hintDark.withAlpha(60),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: AppColors.hintDark,
          size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<CartViewModel>(
          viewModel: CartViewModel(),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.carts.isEmpty) {
              return Center(child: Image.asset('assets/images/cart_empty.png'));
            }
            return ListView.builder(
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
                      ClipRRect(
                        borderRadius: AppStyles.radiusNormal,
                        child: cart.product.images.isEmpty
                            ? Image.asset('assets/images/placeholder.jpg')
                            : Image.network(cart.product.images.first.name),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.product.name,
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  NumberFormat().format(cart.product.price),
                                  style: const TextStyle(
                                    color: AppColors.hintDark,
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
                                      color: AppColors.hintDark,
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
                                  right: AppStyles.radiusNormal.topRight)),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
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
            );
          },
        ),
      ),
    );
  }
}
