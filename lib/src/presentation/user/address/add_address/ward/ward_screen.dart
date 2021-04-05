import 'package:flutter/material.dart';
import '../../../../../resources/resources.dart';
import '../../../../presentation.dart';

class WardScreen extends StatelessWidget {
  final String districtID;

  const WardScreen({Key key, this.districtID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'Ward'),
      body: SafeArea(
        child: FutureBuilder<List<Ward>>(
            future: AddressRepository().getWards(districtID),
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
                      title: Text(item.nameWithType ?? ""),
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
