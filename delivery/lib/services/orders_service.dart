import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../models/orders_model.dart';

class OrderService{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('orders');

// get products from the firebase
  Future getOrders() async{
    User? user = authInstance.currentUser;
    try{
      var myDocuments = await  _ref.where('userId', isEqualTo: user!.uid).get();
    if (myDocuments.docs.isNotEmpty){
      return myDocuments
              .docs
              .map((snapshot) => 
              OrderModel.fromMap(snapshot.data() as Map<String, dynamic>)).toList();
    }
    } catch(e){
      if( e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
}