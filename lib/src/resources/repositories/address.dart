import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../utils/shared_pref.dart';
import '../../configs/configs.dart';
import '../resources.dart';

class AddressRepository {
  Future<Response> getAddress(String token) async {
    try {
      final response = await DioService().get(
        AppEndpoint.getAddress,
        options: RequestOptions(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> addAddress(AddressDatum address, String token) async {
    try {
      final params = FormData.fromMap({
        'city': address.city,
        'district': address.district,
        'ward': address.ward,
        'address': address.address,
      });

      final response = await DioService().post(
        AppEndpoint.getAddress,
        data: params,
        options: RequestOptions(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> deleteAddress(int id) async {
    try {
      final response = await DioService().delete(
        '${AppEndpoint.getAddress}${'/$id'}',
        options: RequestOptions(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${SharedPref.getToken()}'
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<List<City>> getCities() async {
    final cites = <City>[];
    final response = await Dio().get(
      'https://raw.githubusercontent.com/madnh/hanhchinhvn/master/dist/tinh_tp.json',
    );
    Map.from(json.decode(response.data)).forEach((key, value) {
      cites.add(City.fromJson(value));
    });
    return cites;
  }

  Future<List<District>> getDistricts(String cityID) async {
    final districts = <District>[];
    final response = await Dio().get(
        'https://raw.githubusercontent.com/madnh/hanhchinhvn/master/dist/quan_huyen.json');
    Map.from(json.decode(response.data)).forEach((key, value) {
      if (District.fromJson(value).parentCode == cityID) {
        districts.add(District.fromJson(value));
      }
    });
    return districts;
  }

  Future<List<Ward>> getWards(String districtID) async {
    final districts = <Ward>[];
    final response = await Dio().get(
        'https://raw.githubusercontent.com/madnh/hanhchinhvn/master/dist/xa-phuong/$districtID.json');
    Map.from(json.decode(response.data)).forEach((key, value) {
      if (Ward.fromJson(value).parentCode == districtID) {
        districts.add(Ward.fromJson(value));
      }
    });
    return districts;
  }
}
