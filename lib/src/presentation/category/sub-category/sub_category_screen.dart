import 'package:flutter/material.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class SubCategoryScreen extends StatelessWidget {
  final int id;
  final String parentName;

  const SubCategoryScreen({Key key, this.id, this.parentName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<SubCategoryViewModel>(
          viewModel: SubCategoryViewModel(
            productResponse: ProductResponse(),
          ),
          onViewModelReady: (vm) async {
            await vm.init(id);
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    WidgetListProduct(
                      isVertical: true,
                      showSeeAll: false,
                      product: vm.products,
                      onTap: (item) {},
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        parentName,
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.grey),
    );
  }
}
