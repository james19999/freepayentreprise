import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/models/ecommer/promotion.dart';
import 'package:freepayagency/pages/models/ecommer/slider.dart';
import 'package:freepayagency/pages/services/promotion_service.dart';
import 'package:freepayagency/pages/services/slider_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class PromotionController extends ChangeNotifier {
  List<Promotion> promotions = [];

  PromotionController() {
    getPromotion();
  }

  getPromotion() async {
    promotions = await PromotionService.getPromotions();

    notifyListeners();
  }

  delatepromotion(id) async {
    var url = Uri.parse("${BaseUrls}promotions/promotion/delete/$id");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['status'] == true) {
        Toas.getSnackbarsucess(appName, result['message']);
      } else {
        Toas.getSnackbarEror(appName, result['message']);
      }
    }
    notifyListeners();
  }

  AddPromotion(
      File img, normal_price, promot_price, start_date, end_date, title) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
      "normal_price": normal_price,
      "promot_price": promot_price,
      "start_date": start_date,
      "end_date": end_date,
      "title": title,
    });
    try {
      var response = await dio.post("${BaseUrls}promotions/promotion/create",
          data: formData);
      if (response.statusCode == 200) {
        var result = response.data;

        if (result['status'] == true) {
          return true;
        } else {
          Toas.getSnackbarEror(
            appName,
            result['message'],
          );
        }
      }
    } catch (e) {}
  }

  UpdatePromotion(File img, normal_price, promot_price, start_date, end_date,
      title, id) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
      "normal_price": normal_price,
      "promot_price": promot_price,
      "start_date": start_date,
      "end_date": end_date,
      "title": title,
    });
    try {
      var response = await dio
          .post("${BaseUrls}promotions/promotion/update/$id", data: formData);
      if (response.statusCode == 200) {
        var result = response.data;

        if (result['status'] == true) {
          return true;
        } else {
          Toas.getSnackbarEror(
            appName,
            result['message'],
          );
        }
      }
    } catch (e) {}
  }
}

final PromotionProvider = ChangeNotifierProvider<PromotionController>(
  (ref) {
    return PromotionController();
  },
);
