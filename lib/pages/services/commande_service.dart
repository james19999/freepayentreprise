import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/order.dart';
import 'package:freepayagency/pages/models/ecommer/order_item.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class CommandeService {
  static Future<List<Order>> getOrders() async {
    var url = Uri.parse("${BaseUrls}orders");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['Orders'];
      return List<Order>.from(result.map((order) => Order.fromJson(order)));
    } else {
      throw Exception('fail to loader');
    }
  }

  static Future<List<Ordersitem>> getOrderItems(id) async {
    var url = Uri.parse("${BaseUrls}order_view/$id");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['ordersitems'];
      return List<Ordersitem>.from(
          result.map((order) => Ordersitem.fromJson(order)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
