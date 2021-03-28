import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoaluan_totnghiep_mobile/src/configs/configs.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/presentation.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/models/models.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/product.dart';
import 'package:khoaluan_totnghiep_mobile/src/utils/routers.dart';
import 'product.dart';

import '../base/base.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  const ProductScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SafeArea(
        child: BaseWidget<ProductViewModel>(
          viewModel: ProductViewModel(productResponse: ProductResponse()),
          onViewModelReady: (vm) async {
            await vm.init(id);
          },
          builder: (context, vm, widget) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WidgetImageCarousel(images: vm.product.data.images),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: AppStyles.paddingBody,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              vm.product.data.name,
                                              style: GoogleFonts.notoSans(
                                                color: AppColors.textDark,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'bed frame, birch/Luroy, Queen',
                                              style: GoogleFonts.inter(
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        vm.product.data.price.toString(),
                                        style: GoogleFonts.inter(
                                          color: AppColors.textDark,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(vm.product.data.desc),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              title: const Text('Comments'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return CommentDialog(
                                        productId: vm.product.data.id);
                                  }),
                                );
                              },
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            ListTile(
                              title: const Text('Ratings'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return RatingDialog(
                                        productId: vm.product.data.id);
                                  }),
                                );
                              },
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            ExpansionTile(
                              collapsedBackgroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              title: Text(
                                'Attributes',
                                style: TextStyle(color: AppColors.textDark),
                              ),
                              children: [
                                Text('desc 1 : 10kg'),
                                Text('desc 1 : 10kg'),
                                Text('desc 1 : 10kg'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primary,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text('Add to cart'),
                    ),
                  ),
                ],
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
        'Detail',
        style: TextStyle(
          color: Colors.grey.shade800,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.grey),
      actions: [
        IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {})
      ],
    );
  }
}

class WidgetImageCarousel extends StatefulWidget {
  final List<ProductImage> images;

  const WidgetImageCarousel({Key key, this.images}) : super(key: key);

  @override
  _WidgetImageCarouselState createState() => _WidgetImageCarouselState();
}

class _WidgetImageCarouselState extends State<WidgetImageCarousel> {
  CarouselController _carouselController;
  int _current;

  @override
  void initState() {
    _carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.images.isEmpty)
          Image.asset(
            'assets/images/placeholder.jpg',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        else
          CarouselSlider(
            carouselController: _carouselController,
            items: widget.images.map((e) {
              return Image.network(
                e.image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true,
                height: 300,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.only(bottom: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10)),
            child: widget.images.isEmpty
                ? const Text('0/0')
                : Text('${_current + 1}/${widget.images.length}'),
          ),
        ),
      ],
    );
  }
}
