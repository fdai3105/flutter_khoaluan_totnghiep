import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../configs/configs.dart';
import '../../resources/resources.dart';
import '../presentation.dart';

class CategoryScreen extends StatelessWidget {
  final int id;
  final String parentName;
  final String parentImage;

  const CategoryScreen({
    Key key,
    this.id,
    this.parentName,
    this.parentImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
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
    final theme = Theme.of(context);
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: theme.backgroundColor,
            iconTheme: theme.iconTheme,
            elevation: 0,
            title: Text(
              parentName,
              style: theme.textTheme.headline6,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppEndpoint.domain + parentImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ];
      },
      body: vm.isLoading
          ? const WidgetLoading()
          : WidgetIndicator(
              expanded: false,
              onRefresh: () => vm.init(id),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    WidgetListCategory(
                      onTap: (item) => pushNewScreen(
                        context,
                        screen: SubCategoryScreen(
                          id: item.id,
                          name: item.name,
                          image: item.image,
                        ),
                      ),
                      category: vm.subCategory,
                      axis: Axis.horizontal,
                    ),
                    const SizedBox(height: 20),
                    WidgetListProduct(
                      axis: Axis.vertical,
                      showSeeAll: false,
                      padding: AppStyles.paddingBody,
                      product: vm.products,
                      onTap: (item) {
                        pushNewScreen(
                          context,
                          screen: ProductScreen(id: item.id,name: item.name),
                          withNavBar: false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
