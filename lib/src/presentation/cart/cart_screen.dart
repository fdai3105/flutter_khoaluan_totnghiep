import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/shared_pref.dart';
import '../base/base.dart';
import 'cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              SharedPref.removeCarts();
            },
          )
        ],
      ),
      body: SafeArea(
        child: BaseWidget<CartViewModel>(
          viewModel: CartViewModel(),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context,vm,child) {
            if(vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('cart screen'),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.carts.length,
                    itemBuilder: (context, index) {
                      final cart =  vm.carts[index];
                      return Row(
                        children: [
                          Column(
                            children: [
                              Text('Quantity: ${cart.quantity}'),
                              Text('Name: ${cart.product.name}'),
                              Text('Price: ${cart.product.price}'),
                            ],
                          ),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  vm.increase(cart);
                                },
                                child: const Text('+'),
                              ),
                              TextButton(
                                onPressed: () {
                                  vm.decrease(cart);
                                },
                                child: const Text('-'),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
