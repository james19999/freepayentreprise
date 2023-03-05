import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/clients/add_client.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/services/category_services.dart';
import 'package:freepayagency/pages/services/client_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class CategoryController extends ChangeNotifier {
  List<Categorys> category = [];
  List filteredTempCropList = [];

  CategoryController() {
    getCategorys();
  }

  getCategorys() async {
    category = await CategoryService.getCategory();
    filteredTempCropList = category;
    notifyListeners();
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
    notifyListeners();
  }

  uploader(name, image) async {
    Dio dio = Dio();
    var formData = FormData.fromMap({
      'name': name,
      'img': image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split("/")?.last)
          : null,
    });
  }

  uploadImage(name, File img) async {
    Dio dio = Dio();
    String fileName = img.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": name,
      "img": await MultipartFile.fromFile(img.path, filename: fileName),
    });
    try {
      var response = await dio.post("${BaseUrls}categorys/category/create",
          data: formData);
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

  filterCrop(value) {
    filteredTempCropList = category
        .where((croplist) =>
            croplist.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

final CategoryProviders = ChangeNotifierProvider<CategoryController>(
  (ref) {
    return CategoryController();
  },
);
