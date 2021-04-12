import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BaseWidget<CategoryTabViewModel>(
        viewModel: CategoryTabViewModel(
          response: CategoryResponse(),
        ),
        onViewModelReady: (vm) async {
          await vm.init();
        },
        builder: (context, vm, child) {
          return _mobile(context, vm);
        },
      ),
    );
  }

  Widget _mobile(BuildContext context, CategoryTabViewModel vm) {
    return Column(
      children: [
        const WidgetAppBar(title: 'Categories', centerTitle: false),
        WidgetListCategory(category: vm.categories, isLoading: vm.isLoading),
      ],
    );
  }
}