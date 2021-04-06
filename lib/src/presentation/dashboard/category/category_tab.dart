import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
          categoryResponse: CategoryResponse(),
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
        if (vm.isLoading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else
          Expanded(
            child: GlowingOverscrollIndicator(
              color: AppColors.primary,
              axisDirection: AxisDirection.down,
              child: GridView.builder(
                padding: AppStyles.paddingBody,
                shrinkWrap: true,
                itemCount: vm.categories.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 0.7,
                ),
                itemBuilder: (context, index) {
                  final item = vm.categories.data[index];
                  return GestureDetector(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: CategoryScreen(
                          id: item.id,
                          parentName: item.name,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: WidgetImage(image: item.image)),
                        const SizedBox(height: 4),
                        Text(
                          item.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
