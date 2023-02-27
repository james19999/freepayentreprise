import 'dart:convert';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/models/cart_client.dart';
import 'package:http/http.dart' as http;

import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';

class Cartservices {
  static Future<List<Cart>> getClientCart() async {
    var url = Uri.parse("${BaseUrl}get/cart/with/company");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${localstorage.token}"
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['datas'];
      return List<Cart>.from(result.map((cart) => Cart.fromJson(cart)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
