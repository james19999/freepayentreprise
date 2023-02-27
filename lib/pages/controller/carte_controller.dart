import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/models/cart_client.dart';
import 'package:freepayagency/pages/services/carte_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class CartCostumerController extends ChangeNotifier {
  List<Cart> cartes = [];
  List filteredTempCropList = [];

  CartCostumerController() {
    getcartcompany();
  }

  getcartcompany() async {
    try {
      cartes = await Cartservices.getClientCart();
      filteredTempCropList = cartes;
    } catch (e) {}
    notifyListeners();
  }

  //recherche carte
  filterCrop(value) {
    filteredTempCropList = cartes
        .where((croplist) =>
            croplist.client!.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  CreateCarte(Cart carte) async {
    var url = Uri.parse("${BaseUrl}create/cart");
    final response = await http.post(url, body: {
      "amount": carte.amount.toString(),
      "client_id": carte.clientId.toString(),
      "companyId": localstorage.idcompany.toString(),
    }, headers: {
      "Authorization": "Bearer ${localstorage.token}"
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result['status'] == true) {
        return true;
      } else {
        Toas.getSnackbarEror(
          appName,
          result['message'],
        );
      }
    }
  }

  //Créditer une carte

  CrediteCarte(amount, code) async {
    var url = Uri.parse("${BaseUrl}add/amount/with/cart/$code");
    final response = await http.post(url, body: {
      "amount": amount.toString(),
    }, headers: {
      "Authorization": "Bearer ${localstorage.token}"
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result['status'] == true) {
        return true;
      } else {
        Toas.getSnackbarEror(
          appName,
          result['message'],
        );
      }
    }
    notifyListeners();
  }

  //débiter une carte
  DebiteCarte(amounts, code) async {
    var url = Uri.parse("${BaseUrl}verifyCart/$code");
    final response = await http.post(url, body: {
      "amounts": amounts.toString(),
    }, headers: {
      "Authorization": "Bearer ${localstorage.token}"
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result['status'] == true) {
        return true;
      } else {
        Toas.getSnackbarEror(
          appName,
          result['message'],
        );
      }
    }
    notifyListeners();
  }

  // validation de la transaction
  Validationtransaction(code) async {
    var url = Uri.parse("${BaseUrl}validate/transaction/$code");
    final response = await http.post(url,
        body: {}, headers: {"Authorization": "Bearer ${localstorage.token}"});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result['status'] == true) {
        return true;
      } else {
        Toas.getSnackbarEror(
          appName,
          result['message'],
        );
      }
    }
    notifyListeners();
  }

  //activé désactivé une carte
  ActivDesactiveCart(code) async {
    var url = Uri.parse("${BaseUrl}ActivDesactiveCart/$code");
    final response = await http.post(url,
        body: {}, headers: {"Authorization": "Bearer ${localstorage.token}"});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result['status'] == true) {
        Toas.getSnackbarsucess(
          appName,
          result['message'],
        );
      } else {
        Toas.getSnackbarEror(
          appName,
          result['message'],
        );
      }
    }
    notifyListeners();
  }
}

final CartProviders = ChangeNotifierProvider<CartCostumerController>(
  (ref) {
    return CartCostumerController();
  },
);
