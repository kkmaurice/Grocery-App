import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/product_models.dart';
import 'package:flutter/services.dart';

class ProdService{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('products');

// get products from the firebase
  Future getProduct() async{
    try{
      var myDocuments = await  _ref.get();
    if (myDocuments.docs.isNotEmpty){
      return myDocuments
              .docs
              .map((snapshot) => 
              ProductModel.fromMap(snapshot.data() as Map<String, dynamic>)).toList();
    }
    } catch(e){
      if( e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
}