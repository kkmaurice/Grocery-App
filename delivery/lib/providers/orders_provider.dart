// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:delivery/services/orders_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/orders_model.dart';

class OrdersProvider with ChangeNotifier{
  List<OrderModel> _orders = [];
  List<OrderModel> get getOrders => _orders;

 
  // fetch products
  Future<List<OrderModel>> fetchOrders() async{
    final OrderService _service = OrderService();
    var orders = await _service.getOrders();
    print('$orders ');
    if (orders is List<OrderModel>){
      _orders = orders;
    }
    notifyListeners();
    return _orders;
  }
}