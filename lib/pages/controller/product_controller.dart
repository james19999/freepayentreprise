import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/services/product_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class ProductController extends ChangeNotifier {
  List<Product> product = [];
  List filteredTempCropList = [];

  ProductController() {
    getProducts();
  }

  getProducts() async {
    product = await ProductService.getProducts();
    filteredTempCropList = product;
    notifyListeners();
  }

  AddProduct(name, price, category_id, description, File img) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": name,
      'price': price,
      'description': description,
      'category_id': category_id,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var response =
          await dio.post("${BaseUrls}products/product/create", data: formData);
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

  EditProduct(name, price, category_id, description, File img) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": name,
      'price': price,
      'description': description,
      'category_id': category_id,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var response =
          await dio.post("${BaseUrls}products/product/create", data: formData);
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

  deleteProduct(id) async {
    var url = Uri.parse("${BaseUrls}products/product/delete/$id");
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

  filterCrop(value) {
    filteredTempCropList = product
        .where((croplist) =>
            croplist.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

final ProductProvider = ChangeNotifierProvider<ProductController>(
  (ref) {
    return ProductController();
  },
);
