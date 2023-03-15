import 'package:freepayagency/pages/toas/toas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';

class ResertPasswordController extends ChangeNotifier {
  ResertPasswordController() {}

  sendmail (email) async {
   try {
       var url = Uri.parse("${BaseUrl}sendcode");
      final response = await http.post(url, body: {'email':email});
       if(response.statusCode==200){
          var resul =jsonDecode(response.body);
              if(resul['status']==true){
                 localstorage.resertemail(email);
                return true;
              }else {
                Toas.getSnackbarEror(appName, resul['message']);
              }
       }
   } catch (e) {
     
   }
     }

 validatecode(code) async {

   try {
       var url = Uri.parse("${BaseUrl}verifycode");
      final response = await http.post(url, body: {'code':code});
       if(response.statusCode==200){
          var resul =jsonDecode(response.body);
              if(resul['status']==true){
                return true;
              }else {
                Toas.getSnackbarEror(appName, resul['message']);
              }
       }
   } catch (e) {
     
   }
}

 updatepassword (password) async {
   try {
        var url = Uri.parse("${BaseUrl}upadatepassword");
      final response = await http.post(url, body: {'email':localstorage.emailresert,'password':password});
       if(response.statusCode==200){
          var resul =jsonDecode(response.body);
              if(resul['status']==true){
                return true;
              }else {
                Toas.getSnackbarEror(appName, resul['message']);
              }
       }
   } catch (e) {
     
   }
}

}

final PasswordProvider = ChangeNotifierProvider<ResertPasswordController>(
  (ref) {
    return ResertPasswordController();
  },
);
