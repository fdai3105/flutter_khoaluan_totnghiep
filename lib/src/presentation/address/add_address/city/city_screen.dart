import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../presentation.dart';

class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: WidgetAppBar(title: 'city'.tr),
      body: SafeArea(
        child: FutureBuilder<List<City>>(
            future: AddressRepository().getCities(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context, item);
                      },
                      title: Text(
                        item.name ?? "",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  },
                );
              }
              return const WidgetLoading();
            }),
      ),
    );
  }
}
