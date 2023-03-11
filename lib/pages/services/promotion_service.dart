import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/models/ecommer/promotion.dart';
import 'package:freepayagency/pages/models/ecommer/slider.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class PromotionService {
  static Future<List<Promotion>> getPromotions() async {
    var url = Uri.parse("${BaseUrls}promotions/promotion");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['Promotions'];
      return List<Promotion>.from(
          result.map((promotion) => Promotion.fromJson(promotion)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
