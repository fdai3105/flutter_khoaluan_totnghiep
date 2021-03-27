import 'package:flutter/material.dart';
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
      appBar: _appBar(),
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
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
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
                                  Text(
                                    item.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    WidgetListProduct(
                      isVertical: true,
                      product: vm.products,
                      showSeeAll: false,
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
