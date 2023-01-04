import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class WishListService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('users');
  
  Future<void> addToWishList(String productId, BuildContext ctx) async{
    try{
      final userId = authInstance.currentUser!.uid;
      final wishId = const Uuid().v4();
      await _ref.doc(userId).update(
        {
          'userWish' : FieldValue.arrayUnion(
            [
              {
                'wishlistId': wishId,
                'productId': productId,
              }
            ]
          )
        }
      );
      await Fluttertoast.showToast(
        msg: 'Item has been added to your wishList',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER
        );
    }on FirebaseException catch(error){
      return GlobalMethods.errorDialog(subtitle: '$error.message', context: ctx);
    }
  }
}