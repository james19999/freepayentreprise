import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/models/ecommer/slider.dart';
import 'package:freepayagency/pages/services/slider_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class SliderController extends ChangeNotifier {
  List<Sliders> slider = [];

  SliderController() {
    getSliders();
  }

  getSliders() async {
    slider = await SliderService.getSlider();

    notifyListeners();
  }

  // delateCategory(id) async {
  //   var url = Uri.parse("${BaseUrls}categorys/category/delete/$id");
  //   final response = await http.delete(url);

  //   if (response.statusCode == 200) {
  //     var result = jsonDecode(response.body);
  //     if (result['status'] == true) {
  //       Toas.getSnackbarsucess(appName, result['message']);
  //     } else {
  //       Toas.getSnackbarEror(appName, result['message']);
  //     }
  //   }
  //   notifyListeners();
  // }

  AddSlider(description, File img) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "description": description,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var response =
          await dio.post("${BaseUrls}sliders/slider/create", data: formData);
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

  UpdateSlider(description, File img, id) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "description": description,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var uri = "${BaseUrls}sliders/slider/update/${id}";
      var response = await dio.post(uri, data: formData);
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
}

final SliderProvider = ChangeNotifierProvider<SliderController>(
  (ref) {
    return SliderController();
  },
);
