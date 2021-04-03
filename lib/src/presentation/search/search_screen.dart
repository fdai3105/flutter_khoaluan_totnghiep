import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../../resources/repositories/product.dart';
import '../presentation.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fieldController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetAppBar(title: 'Search'),
      body: SafeArea(
        child: BaseWidget<SearchViewModel>(
          viewModel: SearchViewModel(productResponse: ProductResponse()),
          onViewModelReady: (vm) {
            vm.init();
          },
          builder: (context, vm, widget) {
            return _body(context, vm, fieldController);
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, SearchViewModel vm,
      TextEditingController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WidgetInputSearch(
            controller: controller,
            padding: AppStyles.paddingBody,
            autoFocus: true,
            onChanged: (value) {
              vm
                ..onSearching(value)
                ..isSearching = true;
            },
            onSubmit: (value) {
              vm.isSearching = false;
            },
          ),
          if (vm.result == null)
            const SizedBox()
          else
            vm.isSearching
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: vm.result.data.length,
                    itemBuilder: (context, index) {
                      final item = vm.result.data[index];
                      return ListTile(
                        onTap: () {
                          controller
                            ..text = item.name
                            ..selection = TextSelection(
                                baseOffset: item.name.length,
                                extentOffset: item.name.length);
                          vm.onSearching(item.name);
                          vm.keyWord = item.name;
                          vm.isSearching = false;
                        },
                        title: Text(item.name),
                      );
                    },
                  )
                : WidgetListProduct(
                    isVertical: true,
                    product: vm.result,
                    padding: AppStyles.paddingBody,
                  ),
        ],
      ),
    );
  }
}
