import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/shared_pref.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('cart screen'),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: SharedPref.getCarts().length,
                itemBuilder: (context, index) {
                  final cart = SharedPref.getCarts()[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ' + cart.quantity.toString()),
                      Text('Name: ' + cart.product.name),
                      Text('Price: ' + cart.product.price.toString()),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
