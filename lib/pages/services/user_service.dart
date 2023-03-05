import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  //change password
  static newPassword(newpassword) async {
    var url = Uri.parse("${BaseUrl}change/Password/Company");
    final response = await http.post(url, body: {
      "newpassword": newpassword
    }, headers: {
      "Authorization": "Bearer ${localstorage.token}",
    });
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['status'] == true) {
        localstorage.deletetoken;
        localstorage.deletename;
        return true;
      }
    }
  }

  static UpdateCompay(name, phone, adress, email, raison, description, password,
      quartier) async {
    var uri = "${BaseUrl}upadate/company/${localstorage.idcompany}";
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "name": name,
      "phone": phone,
      "adress": adress,
      "email": email,
      "raison": raison,
      "description": description,
      "password": password,
      "quartier": quartier,
    });

    try {
      var response = await dio.post(uri,
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer ${localstorage.token}"}));
      print(response);
      if (response.statusCode == 200) {
        var result = response.data;

        if (result['status'] == true) {
          return true;
        } else {
          Toas.getSnackbarEror(
            appName,
            result['status'],
          );
        }
      }
    } catch (e) {}
  }

  static upadatecompanyimage(File img) async {
    var uri = "${BaseUrl}upadate/company/image/${localstorage.idcompany}";
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });

    try {
      var response = await dio.post(uri,
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer ${localstorage.token}"}));
      print(response);
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
