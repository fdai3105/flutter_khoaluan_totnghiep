import 'package:flutter/material.dart';
import '../../configs/configs.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class CategoryScreen extends StatelessWidget {
  final int id;
  final String parentName;

  const CategoryScreen({Key key, this.id, this.parentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(title: parentName),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseWidget<CategoryViewModel>(
          viewModel: CategoryViewModel(
            categoryResponse: CategoryResponse(),
            productResponse: ProductResponse(),
          ),
          onViewModelReady: (vm) async {
            await vm.init(id);
          },
          builder: (context, vm, widget) {
            return _body(context, vm);
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, CategoryViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: AppStyles.paddingBody,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 0.7,
              ),
              itemCount: vm.subCategory.data.length,
              itemBuilder: (context, index) {
                final item = vm.subCategory.data[index];
                return GestureDetector(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: SubCategoryScreen(
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
            const SizedBox(height: 20),
            WidgetListProduct(
              isVertical: true,
              showSeeAll: false,
              padding: AppStyles.paddingBody,
              product: vm.products,
              onTap: (item) {
                pushNewScreen(
                  context,
                  screen: ProductScreen(id: item.id),
                  withNavBar: false,
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
