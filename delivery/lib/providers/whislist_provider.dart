// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/wishlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../consts/firebase_consts.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishlistItems = {};
  Map<String, WishListModel> get getWishlistItems => _wishlistItems;

  // void addRemoveProductToWishlist(String productId){
  //   //final WishListService _service = WishListService();
  //   if(_wishlistItems.containsKey(productId)){
  //     _wishlistItems.remove(productId);
  //   }else{
  //     _wishlistItems.putIfAbsent(productId, () => WishListModel(id: DateTime.now().toString(), productId: productId));
  //   }
  //  // _service.addToWishList(productId, ctx)
  //   notifyListeners();
  // }

  
final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> fetchWishlist() async{
    final User? userId = authInstance.currentUser;
    final _uid = userId?.uid ?? '';
    final DocumentSnapshot userDoc = await userCollection.doc(_uid).get();
    if(userDoc == null){
      return;
    }
    final leng = userDoc.get('userWish').length;
    for (int i=0; i<leng; i++) {
      _wishlistItems.putIfAbsent(userDoc.get('userWish')[i]['productId'], () => WishListModel(
        id: userDoc.get('userWish')[i]['wishlistId'], 
        productId: userDoc.get('userWish')[i]['productId'], 
        ));
    }
    notifyListeners();
  }

   Future<void> removeOneItem(String wishlistId, String productId) async{
    final User? userId = authInstance.currentUser;
    await userCollection.doc(userId!.uid).update(
      {
        'userWish' : FieldValue.arrayRemove(
          [
            {
              'cartId' : wishlistId,
              'wishlistId': productId,
            }
          ]
        )
      }
    );
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  Future<void> clearWishlist() async{
    final User? userId = authInstance.currentUser;
    await userCollection.doc(userId!.uid).update(
      {
        'userWish' : []
      }
    );
    _wishlistItems.clear();
    notifyListeners();
  }
  // void removeOneItem(String productId){
  //   _wishlistItems.remove(productId);
  //   notifyListeners();
  // }

  // void clearWishlist(){
  //   _wishlistItems.clear();
  //   notifyListeners();
  // }

}
