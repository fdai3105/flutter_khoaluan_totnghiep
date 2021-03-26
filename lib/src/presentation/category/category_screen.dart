import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final int id;

  const CategoryScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(id.toString()),
      ),
    );
  }
}
