import 'package:flutter/material.dart';
import '../../../../presentation.dart';
import '../../../../../resources/resources.dart';

class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'City'),
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
