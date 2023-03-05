import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Product>> getProducts() async {
    var url = Uri.parse("${BaseUrls}products/product");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['product'];
      return List<Product>.from(result.map((prod) => Product.fromJson(prod)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
