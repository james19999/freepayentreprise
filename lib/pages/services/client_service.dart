import 'dart:convert';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:http/http.dart' as http;

import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';

class Clientservices {
  static Future<List<ClientModel>> getClient() async {
    var url = Uri.parse("${BaseUrl}get/client");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      "Authorization": "Bearer ${localstorage.token}"
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['datas'];
      return List<ClientModel>.from(
          result.map((client) => ClientModel.fromJson(client)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
