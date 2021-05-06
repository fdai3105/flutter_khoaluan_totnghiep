// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../resources/resources.dart';
import '../../../../utils/routers.dart';
import '../../../../utils/shared_pref.dart';
import '../../../presentation.dart';

class SelectAddressScreen extends StatefulWidget {
  final int selected;

  const SelectAddressScreen({Key key, this.selected}) : super(key: key);

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  int select;

  @override
  void initState() {
    if (widget.selected != null) {
      select = widget.selected;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: WidgetAppBar(
        title: 'Select address',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.address);
            },
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: AddressRepository().getAddress(SharedPref.getToken()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WidgetLoading();
            } else {
              if (snapshot.hasData) {
                final data = Address.fromJson(snapshot.data.data);
                return ListView.builder(
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    final item = data.data[index];
                    return _item(context, item);
                  },
                );
              } else {
                return const Center(child: Text('Empty'));
              }
            }
          },
        ),
      ),
    );
  }

  Widget _item(BuildContext context, AddressDatum address) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: () {
        setState(() {
          select = address.id;
        });
        Navigator.pop(context, address.id);
      },
      title: Row(
        children: [
          Text(
            address.name,
            style: theme.textTheme.bodyText1,
          ),
          const SizedBox(width: 10),
          Text(
            address.phone,
            style: theme.textTheme.bodyText1,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.address,
            style: theme.textTheme.subtitle1,
          ),
          Text(
            address.ward,
            style: theme.textTheme.subtitle1,
          ),
          Text(
            '${address.district}, ${address.city}',
            style: theme.textTheme.subtitle1,
          ),
        ],
      ),
      leading: Radio(
        value: address.id,
        groupValue: select,
        onChanged: (value) {
          setState(() {
            select = value;
          });
        },
      ),
    );
  }
}
