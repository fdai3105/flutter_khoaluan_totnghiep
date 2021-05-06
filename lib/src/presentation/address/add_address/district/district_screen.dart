import 'package:flutter/material.dart';
import '../../../presentation.dart';
import '../../../../resources/resources.dart';

class DistrictScreen extends StatelessWidget {
  final String cityID;

  const DistrictScreen({Key key, this.cityID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const WidgetAppBar(title: 'District'),
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
                      title: Text(
                        item.nameWithType ?? "",
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
