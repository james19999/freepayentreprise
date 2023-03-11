import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/models/ecommer/slider.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class SliderService {
  static Future<List<Sliders>> getSlider() async {
    var url = Uri.parse("${BaseUrls}sliders/slider");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['Sliders'];
      return List<Sliders>.from(
          result.map((slider) => Sliders.fromJson(slider)));
    } else {
      throw Exception('fail to loader');
    }
  }
}
