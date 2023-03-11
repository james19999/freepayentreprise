import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/models/ecommer/pub.dart';
import 'package:freepayagency/pages/services/pub_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class PubController extends ChangeNotifier {
  List<Pubs> pubs = [];

  PubController() {
    getPub();
  }

  getPub() async {
    pubs = await PubService.getPubs();

    notifyListeners();
  }

  AddPub(File img) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var response =
          await dio.post("${BaseUrls}pubs/pub/create", data: formData);
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

  UpdatePub(File img, id) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var uri = "${BaseUrls}pubs/pub/update/${id}";
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

final PubProvider = ChangeNotifierProvider<PubController>(
  (ref) {
    return PubController();
  },
);
