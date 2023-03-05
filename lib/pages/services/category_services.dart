import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<List<Categorys>> getCategory() async {
    var url = Uri.parse("${BaseUrls}categorys/category");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['category'];
      return List<Categorys>.from(
          result.map((categ) => Categorys.fromJson(categ)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
