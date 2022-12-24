import 'package:delivery/models/cart_model.dart';
import 'package:delivery/models/wishlist_model.dart';
import 'package:flutter/cupertino.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishlistItems = {};
  Map<String, WishListModel> get getWishlistItems => _wishlistItems;

  void addRemoveProductToWishlist(String productId){
    if(_wishlistItems.containsKey(productId)){
      _wishlistItems.remove(productId);
    }else{
      _wishlistItems.putIfAbsent(productId, () => WishListModel(id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  // void removeOneItem(String productId){
  //   _wishlistItems.remove(productId);
  //   notifyListeners();
  // }

  void clearWishlist(){
    _wishlistItems.clear();
    notifyListeners();
  }
}
