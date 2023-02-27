import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class UserCostumerController extends ChangeNotifier {
  UserCostumerController() {}

  // ignore: non_constant_identifier_names
  AuthConstumer(email, password) async {
    var data = {
      "email": email.toString(),
      "password": password.toString(),
    };
    // print(data);
    var url = Uri.parse("${BaseUrl}logincompany");
    // print(url);
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['status'] == true) {
        localstorage.costumerinfo(
            username: result['name'],
            token: result['token'],
            idcompany: result['id']);

        return true;
      } else {
        return false;
      }
    }
  }

  static LogoutUser() async {
    var url = Uri.parse("${BaseUrl}logout/company");
    final response = await http
        .post(url, headers: {"Authorization": "Bearer ${localstorage.token}"});

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['status'] == true) {
        localstorage.deletetoken;
        localstorage.deletename;
        return true;
      }
    }
  }
}

final AuthProviders = ChangeNotifierProvider<UserCostumerController>(
  (ref) {
    return UserCostumerController();
  },
);
