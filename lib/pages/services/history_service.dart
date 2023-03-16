import 'dart:convert';

import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/models/history.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class HistoryService {
     static Future<List<History>> gethsitoryoffcompanytoday () async {
         var url = Uri.parse("${BaseUrl}gethsitoryoffcompanytoday");
          final response = await http.get(url, headers: {
            'content-type': 'application/json',
            "Authorization": "Bearer ${localstorage.token}"
          });

        if (response.statusCode == 200) {
          var result = jsonDecode(response.body)['history'];
          return List<History>.from(result.map((histor) => History.fromJson(histor)));
        } else {
          throw Exception('fail to loader');
        }

      }

     static Future<List<History>> getallhistory () async {
        var url = Uri.parse("${BaseUrl}getallhistory");
          final response = await http.get(url, headers: {
            'content-type': 'application/json',
            "Authorization": "Bearer ${localstorage.token}"
          });
         if (response.statusCode == 200) {
          var result = jsonDecode(response.body)['history'];
          return List<History>.from(result.map((histor) => History.fromJson(histor)));
        } else {
          throw Exception('fail to loader');
        }
      }

     static Future<List<History>> gethistoryoffweek () async {
          var url = Uri.parse("${BaseUrl}gethistoryoffweek");
          final response = await http.get(url, headers: {
            'content-type': 'application/json',
            "Authorization": "Bearer ${localstorage.token}"
          });

        if (response.statusCode == 200) {
          var result = jsonDecode(response.body)['history'];
          return List<History>.from(result.map((histor) => History.fromJson(histor)));
        } else {
          throw Exception('fail to loader');
        }

      }

    static  Future<List<History>> gethistoryoffmonth () async {

      var url = Uri.parse("${BaseUrl}gethistoryoffmonth");
          final response = await http.get(url, headers: {
            'content-type': 'application/json',
            "Authorization": "Bearer ${localstorage.token}"
          });

        if (response.statusCode == 200) {
          var result = jsonDecode(response.body)['history'];
          return List<History>.from(result.map((histor) => History.fromJson(histor)));
        } else {
          throw Exception('fail to loader');
        }
      }
}