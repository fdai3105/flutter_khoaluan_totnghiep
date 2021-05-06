// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

// Project imports:
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
        title: const Text(
          'Ratings',
          style: TextStyle(color: AppColors.dark),
        ),
        centerTitle: true,
        leading: IconButton(
          icon:const Icon(Icons.close_outlined, color: AppColors.dark),
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
            return _body(vm);
          },
        ),
      ),
    );
  }

  Widget _body(RatingViewModel vm) {
    return SingleChildScrollView(
      padding: AppStyles.paddingBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vm.sumRating.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  RatingBar.builder(
                    glow: false,
                    ignoreGestures: true,
                    itemSize: 20,
                    initialRating: vm.sumRating,
                    unratedColor: Colors.grey.shade400,
                    itemBuilder: (context, index) {
                      return const Icon(Icons.star_outlined, color: AppColors.dark);
                    },
                    onRatingUpdate: (rating) {},
                  ),
                  Text(' (${vm.countRating})'),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.dark45, thickness: 0.8),
          WidgetRatingList(ratings: vm.ratings.data),
        ],
      ),
    );
  }
}

class WidgetRatingList extends StatelessWidget {
  final List<RatingDatum> ratings;

  const WidgetRatingList({
    Key key,
    @required this.ratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ratings.length,
      itemBuilder: (context, index) {
        final item = ratings[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar.builder(
                  glow: false,
                  ignoreGestures: true,
                  itemSize: 20,
                  unratedColor: Colors.grey.shade400,
                  initialRating: item.rating.toDouble(),
                  itemBuilder: (context, index) {
                    return const Icon(Icons.star_outlined, color: AppColors.dark);
                  },
                  onRatingUpdate: (rating) {},
                ),
                Row(
                  children: [
                    Text(
                      item.user.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Text(' · '),
                    Text(timeago.format(item.createdAt)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(item.comment),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
