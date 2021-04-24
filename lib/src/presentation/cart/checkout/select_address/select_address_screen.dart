import 'package:flutter/material.dart';
import '../../../../configs/configs.dart';
import '../../../../utils/shared_pref.dart';
import '../../../../utils/routers.dart';
import '../../../../resources/resources.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
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
              return WidgetLoading();
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
    return ListTile(
      onTap: () {
        setState(() {
          select = address.id;
        });
        Navigator.pop(context, address.id);
      },
      title: Row(
        children: [
          Text(address.name),
          const SizedBox(width: 10),
          Text(
            address.phone,
            style: const TextStyle(color: AppColors.dark45),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.address,
            style: TextStyle(color: AppColors.dark),
          ),
          Text(
            address.ward,
            style: TextStyle(color: AppColors.dark),
          ),
          Text(
            '${address.district}, ${address.city}',
            style: TextStyle(color: AppColors.dark),
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
