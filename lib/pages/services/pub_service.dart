import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/models/ecommer/pub.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class PubService {
  static Future<List<Pubs>> getPubs() async {
    var url = Uri.parse("${BaseUrls}pubs/pub");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['Pubs'];
      return List<Pubs>.from(result.map((pubs) => Pubs.fromJson(pubs)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
