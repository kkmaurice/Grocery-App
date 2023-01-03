import 'package:delivery/models/cart_model.dart';
import 'package:delivery/services/cart_service.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItem = {};
  Map<String, CartModel> get getCartItems => _cartItem;

  // void addProductsToCart(String productId, int quantity) {
  //   final CartService _service = CartService();
  //   _cartItem.putIfAbsent(
  //       productId,
  //       () => CartModel(
  //           id: DateTime.now().toString(),
  //           productId: productId,
  //           quantity: quantity));
  //           notifyListeners();
  // }

  void increaseQuantityByOne(String productId){
    _cartItem.update(productId, (value) => CartModel(id: value.id, productId: productId, quantity: value.quantity + 1));
    notifyListeners();
  }

  void decreaseQuantityByOne(String productId){
    _cartItem.update(productId, (value) => CartModel(id: value.id, productId: productId, quantity:  value.quantity - 1 ));
    notifyListeners();
  }

  void removeOneItem(String productId){
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clearCart(){
    _cartItem.clear();
    notifyListeners();
  }
}
