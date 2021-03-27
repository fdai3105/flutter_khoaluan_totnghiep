import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/product.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/resources.dart';
import 'package:rxdart/rxdart.dart';
import '../../presentation.dart';

class RatingViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  RatingViewModel({this.productResponse});

  final _rating = BehaviorSubject<Ratings>();

  Ratings get rating => _rating.value;

  set rating(Ratings value) {
    _rating.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final ratingsRepo = await productResponse.getRatingsByProduct(id);
    if(ratingsRepo.statusCode == 200) {
      rating = Ratings.fromJson(ratingsRepo.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _rating.close();
    return super.dispose();
  }
}
