import 'package:flutter/material.dart';
import '../../../configs/configs.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class RatingDialog extends StatelessWidget {
  final int productId;

  const RatingDialog({Key key, this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Ratings',
          style: TextStyle(color: AppColors.textDark),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close_outlined, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: BaseWidget<RatingViewModel>(
          viewModel: RatingViewModel(productResponse: ProductResponse()),
          onViewModelReady: (vm) async {
            await vm.init(productId);
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: vm.rating.data.length,
              itemBuilder: (context, index) {
                final item = vm.rating.data[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.rating.toString()),
                    Text(item.comment),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
