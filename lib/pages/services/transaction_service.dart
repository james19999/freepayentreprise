import 'dart:convert';

import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/models/transaction.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class Transactionservice {
  // get all transactions by created_at
  static Future<dynamic> getalltransaction(id) async {
    var url = Uri.parse("${BaseUrl}get/cart/with/company/transaction/$id");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'Authorization': "Bearer ${localstorage.token}"
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['datas'];

      return List<Transaction>.from(
          result.map((transaction) => Transaction.fromJson(transaction)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
