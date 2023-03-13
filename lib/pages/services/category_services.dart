import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/toas/toas.dart';
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

  delateCategory(id) async {
    var url = Uri.parse("${BaseUrls}categorys/category/delete/$id");
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['status'] == true) {
        Toas.getSnackbarsucess(appName, result['message']);
      } else {
        Toas.getSnackbarEror(appName, result['message']);
      }
    }
  }

  static uploader(name, image) async {
    Dio dio = Dio();
    var formData = FormData.fromMap({
      'name': name,
      'img': image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split("/")?.last)
          : null,
    });
  }

  static uploadImage(name, File img) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": name,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    var url = "${BaseUrls}categorys/category/create";
    print(url);
    // var response = await dio.post(url, data: formData);
    // print(response.statusCode);
    // try {
    //   if (response.statusCode == 201) {
    //     var result = response.data;

    //     return true;
    //   } else {
    //     Toas.getSnackbarEror(
    //       appName,
    //       "Une erreur est surveneue lors de la créaction",
    //     );
    //   }
    // } catch (e) {}
  }

  uploadImageCategoryUpdate(name, File img, id) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": name,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var uri = "${BaseUrls}categorys/category/update/${id}";
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
