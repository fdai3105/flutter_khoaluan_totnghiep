import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../utils/utils.dart';
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
        const WidgetAppbar(
          title: 'Categories',
        ),
        if (vm.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          Expanded(
            child: GridView.builder(
              padding: AppStyles.paddingBody,
              shrinkWrap: true,
              itemCount: vm.categories.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
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
                      Flexible(
                        child: Image.network(
                          'https://assets.weimgs.com/weimgs/rk/images/wcm/products/202110/0069/img47j.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(item.name ?? ''),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
