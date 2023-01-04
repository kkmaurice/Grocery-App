// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/services/cart_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../consts/firebase_consts.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItem = {};
  Map<String, CartModel> get getCartItems => _cartItem;

final User? userId = authInstance.currentUser;
final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> fetchCart() async{
       final _uid = userId!.uid;
    final DocumentSnapshot userDoc = await userCollection.doc(_uid).get();
    if(userDoc == null){
      return;
    }
    final leng = userDoc.get('userCart').length;
    for (int i=0; i<leng; i++) {
      _cartItem.putIfAbsent(userDoc.get('userCart')[i]['productId'], () => CartModel(
        id: userDoc.get('userCart')[i]['cartId'], 
        productId: userDoc.get('userCart')[i]['productId'], 
        quantity: userDoc.get('userCart')[i]['quantity']
        ));
    }
    notifyListeners();
  }


  void increaseQuantityByOne(String productId){
    _cartItem.update(productId, (value) => CartModel(id: value.id, productId: productId, quantity: value.quantity + 1));
    notifyListeners();
  }

  void decreaseQuantityByOne(String productId){
    _cartItem.update(productId, (value) => CartModel(id: value.id, productId: productId, quantity:  value.quantity - 1 ));
    notifyListeners();
  }

  Future<void> removeOneItem(String cartId, String productId, int quantity) async{
    await userCollection.doc(userId!.uid).update(
      {
        'userCart' : FieldValue.arrayRemove(
          [
            {
              'cartId' : cartId,
              'productId': productId,
              'quantity' : quantity
            }
          ]
        )
      }
    );
    _cartItem.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearCart() async{
    await userCollection.doc(userId!.uid).update(
      {
        'userCart' : []
      }
    );
    _cartItem.clear();
    notifyListeners();
  }
}
