import 'package:delivery/models/viewed_model.dart';
import 'package:flutter/cupertino.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedRecently> _viewedProdlistItems = {};
  Map<String, ViewedRecently> get getViewedlistItems => _viewedProdlistItems;

  void addProductToHistory(String productId){
      _viewedProdlistItems.putIfAbsent(productId, () =>ViewedRecently(id: DateTime.now().toString(), productId: productId));
    notifyListeners();
  }

  void clearWishlist(){
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
