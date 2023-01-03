import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class CartService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('users');
  
  Future<void> addToCart(String productId, int quantity, BuildContext ctx) async{
    try{
      final userId = authInstance.currentUser!.uid;
      final cartId = const Uuid().v4();
      await _ref.doc(userId).update(
        {
          'userCart' : FieldValue.arrayUnion(
            [
              {
                'cartId': cartId,
                'productId': productId,
                'quantity': quantity
              }
            ]
          )
        }
      );
      await Fluttertoast.showToast(
        msg: 'Item has been added to your cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER
        );
    }on FirebaseException catch(error){
      return GlobalMethods.errorDialog(subtitle: '$error.message', context: ctx);
    }
  }

  // Future addCart(CartModel cart, BuildContext ctx) async{
  //   try{
  //     final userId = authInstance.currentUser!.uid;
  //     final cartId = const Uuid().v4();
  //     await _ref.doc(userId).set(
  //       {
  //         'userCart' : CartModel(id: cartId, productId: cart.productId, quantity: cart.quantity)
         
  //       }
  //     );
  //     // update(
  //     //   {
  //     //     'userCart' : FieldValue.arrayUnion(
  //     //       [
  //     //         CartModel(id: cartId, productId: cart.productId, quantity: cart.quantity)
  //     //       ]
  //     //     )
  //     //   }
  //     // );
  //     await Fluttertoast.showToast(
  //       msg: 'Item has been added to your cart',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER
  //       );
  //   }on FirebaseException catch(error){
  //     return GlobalMethods.errorDialog(subtitle: '$error.message', context: ctx);
  //   }
  // }
}