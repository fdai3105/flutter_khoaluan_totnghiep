import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import '../../resources/repositories/product.dart';
import '../presentation.dart';

class SearchScreen extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            return Column(
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
                const SizedBox(height: 10),
                if (vm.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  _body(context, vm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, SearchViewModel vm) {
    return Expanded(
      child: SingleChildScrollView(
        child: _result(context, vm),
      ),
    );
  }

  Widget _result(BuildContext context, SearchViewModel vm) {
    if (vm.result == null) {
      return const SizedBox();
    }
    if (!vm.isSearching && vm.result.data.isEmpty) {
      return Center(child: Image.asset('assets/images/search_empty.png'));
    }
    return vm.isSearching
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
                  vm
                    ..onSearching(item.name)
                    ..keyWord = item.name
                    ..isSearching = false;
                },
                title: Text(item.name),
              );
            },
          )
        : WidgetListProduct(
            showSeeAll: false,
            isVertical: true,
            product: vm.result,
            padding: AppStyles.paddingBody,
          );
  }
}
