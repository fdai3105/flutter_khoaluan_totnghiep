import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/search/search.dart';
import '../presentation.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'Search'),
      body: SafeArea(
        child: BaseWidget<SearchViewModel>(
          viewModel: SearchViewModel(),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, widget) {
            return Column(
              children: [
                WidgetInputSearch(
                  padding: AppStyles.paddingBody,
                  onChanged: (value) {
                    print('');
                  },
                  onSubmit: (value) {},
                ),
                if (vm.result == null)
                  const SizedBox()
                else
                  ListView.builder(
                    itemCount: vm.result.data.length,
                    itemBuilder: (context, index) {
                      final item = vm.result.data[index];
                      return ListTile(
                        title: Text(item.name),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
