import 'package:freepayagency/pages/models/ecommer/order.dart';
import 'package:freepayagency/pages/services/commande_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';

class OrderController extends ChangeNotifier {
  List<Order> order = [];
  OrderController() {
    getOrder();
  }

  getOrder() async {
    order = await CommandeService.getOrders();
    notifyListeners();
  }

  chekfuction(index) async {
    notifyListeners();
  }
}

final OrderProvider = ChangeNotifierProvider<OrderController>(
  (ref) {
    return OrderController();
  },
);
