import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/clients/add_client.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/services/client_service.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:http/http.dart' as http;

class ClientCostumerController extends ChangeNotifier {
  List<ClientModel> clienttable = [];
  List filteredTempCropList = [];
  List<ClientModel> table = [];

  ClientCostumerController() {
    getclients();
  }

  getclients() async {
    try {
      clienttable = await Clientservices.getClient();
      filteredTempCropList = clienttable;

      notifyListeners();
    } catch (e) {}
  }

  //recherche client
  filterCrop(value) {
    filteredTempCropList = clienttable
        .where((croplist) =>
            croplist.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  //add  client
  AddClient(ClientModel client) async {
    var url = Uri.parse("${BaseUrl}create/client/company");
    final response = await http.post(url, body: {
      "name": client.name.toString(),
      "phone": client.phone.toString(),
      "email": client.email.toString(),
      "ville": client.ville.toString(),
      "identify": client.identify.toString(),
      "quartier": client.quartier.toString(),
      "companyId": localstorage.idcompany.toString(),
      "adress": client.adress.toString(),
    }, headers: {
      "Authorization": "Bearer ${localstorage.token}"
    });

    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == true) {
          return true;
        } else {
          var message = result['message'];
          Toas.getSnackbarEror(appName, "L'identifiant existe déjà.");
        }
      }
    } catch (e) {}
    notifyListeners();
  }

  //edit client
  EditClient(ClientModel client, id) async {
    var url = Uri.parse("${BaseUrl}Update/Client/${id}");
    final response = await http.put(url, body: {
      "name": client.name.toString(),
      "phone": client.phone.toString(),
      "email": client.email.toString(),
      "ville": client.ville.toString(),
      "identify": client.identify.toString(),
      "quartier": client.quartier.toString(),
      "companyId": localstorage.idcompany.toString(),
      "adress": client.adress.toString(),
    }, headers: {
      "Authorization": "Bearer ${localstorage.token}"
    });

    try {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == true) {
          return true;
        } else {
          Toas.getSnackbarEror(appName, result['message']);
        }
      }
    } catch (e) {}
    notifyListeners();
  }
}

final ClientProviders = ChangeNotifierProvider<ClientCostumerController>(
  (ref) {
    return ClientCostumerController();
  },
);
