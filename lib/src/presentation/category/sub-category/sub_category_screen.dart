import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class SubCategoryScreen extends StatelessWidget {
  final int id;
  final String name;
  final String image;

  const SubCategoryScreen({
    Key key,
    @required this.id,
    @required this.name,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return WidgetLoading();
            } else {
              if (vm.products.data.isEmpty) {
                return const Center(child: Text('Nothing to show'));
              }
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      iconTheme: IconThemeData(color: AppColors.dark),
                      title: Text(
                        name,
                        style: TextStyle(color: AppColors.dark),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          AppEndpoint.domain + image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      WidgetListProduct(
                        axis: Axis.vertical,
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
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
