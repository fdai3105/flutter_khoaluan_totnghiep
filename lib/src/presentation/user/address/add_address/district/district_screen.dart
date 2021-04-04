import 'package:flutter/material.dart';

import '../../../../../resources/models/district.dart';
import '../../../../../resources/repositories/address.dart';

class DistrictScreen extends StatelessWidget {
  final String cityID;

  const DistrictScreen({Key key, this.cityID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<District>>(
            future: AddressRepository().getDistricts(cityID),
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
                      title: Text(item.name ?? ""),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
