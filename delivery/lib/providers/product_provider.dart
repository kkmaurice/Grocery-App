// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_models.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier{
  //  List<ProductModel> _productsList = [
  //   ProductModel(
  //     id: 'Apricot',
  //     title: 'Apricot',
  //     price: 0.99,
  //     salePrice: 0.49,
  //     imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
  //     productCategory: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Avocado',
  //     title: 'Avocado',
  //     price: 0.88,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/9VKXw5L/Avocat.png',
  //     productCategory: 'Fruits',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Black grapes',
  //     title: 'Black grapes',
  //     price: 1.22,
  //     salePrice: 0.7,
  //     imageUrl: 'https://i.ibb.co/c6w5zrC/Black-Grapes-PNG-Photos.png',
  //     productCategory: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Fresh_green_grape',
  //     title: 'Fresh green grape',
  //     price: 1.5,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/HKx2bsp/Fresh-green-grape.png',
  //     productCategory: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Green grape',
  //     title: 'Green grape',
  //     price: 0.99,
  //     salePrice: 0.4,
  //     imageUrl: 'https://i.ibb.co/bHKtc33/grape-green.png',
  //     productCategory: 'Fruits',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Red apple',
  //     title: 'Red apple',
  //     price: 0.6,
  //     salePrice: 0.2,
  //     imageUrl: 'https://i.ibb.co/crwwSG2/red-apple.png',
  //     productCategory: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   // Vegi
  //   ProductModel(
  //     id: 'Carottes',
  //     title: 'Carottes',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/TRbNL3c/Carottes.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Cauliflower',
  //     title: 'Cauliflower',
  //     price: 1.99,
  //     salePrice: 0.99,
  //     imageUrl: 'https://i.ibb.co/xGWf2rH/Cauliflower.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Cucumber',
  //     title: 'Cucumber',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/kDL5GKg/cucumbers.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Jalape',
  //     title: 'Jalape',
  //     price: 1.99,
  //     salePrice: 0.89,
  //     imageUrl: 'https://i.ibb.co/Dtk1YP8/Jalape-o.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Long yam',
  //     title: 'Long yam',
  //     price: 2.99,
  //     salePrice: 1.59,
  //     imageUrl: 'https://i.ibb.co/V3MbcST/Long-yam.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Onions',
  //     title: 'Onions',
  //     price: 0.59,
  //     salePrice: 0.28,
  //     imageUrl: 'https://i.ibb.co/GFvm1Zd/Onions.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Plantain-flower',
  //     title: 'Plantain-flower',
  //     price: 0.99,
  //     salePrice: 0.389,
  //     imageUrl: 'https://i.ibb.co/RBdq0PD/Plantain-flower.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Potato',
  //     title: 'Potato',
  //     price: 0.99,
  //     salePrice: 0.59,
  //     imageUrl: 'https://i.ibb.co/wRgtW55/Potato.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Radish',
  //     title: 'Radish',
  //     price: 0.99,
  //     salePrice: 0.79,
  //     imageUrl: 'https://i.ibb.co/YcN4ZsD/Radish.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Red peppers',
  //     title: 'Red peppers',
  //     price: 0.99,
  //     salePrice: 0.57,
  //     imageUrl: 'https://i.ibb.co/JthGdkh/Red-peppers.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Squash',
  //     title: 'Squash',
  //     price: 3.99,
  //     salePrice: 2.99,
  //     imageUrl: 'https://i.ibb.co/p1V8sq9/Squash.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Tomatoes',
  //     title: 'Tomatoes',
  //     price: 0.99,
  //     salePrice: 0.39,
  //     imageUrl: 'https://i.ibb.co/PcP9xfK/Tomatoes.png',
  //     productCategory: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   // Grains
  //   ProductModel(
  //     id: 'Corn-cobs',
  //     title: 'Corn-cobs',
  //     price: 0.29,
  //     salePrice: 0.19,
  //     imageUrl: 'https://i.ibb.co/8PhwVYZ/corn-cobs.png',
  //     productCategory: 'Grains',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Peas',
  //     title: 'Peas',
  //     price: 0.99,
  //     salePrice: 0.49,
  //     imageUrl: 'https://i.ibb.co/7GHM7Dp/peas.png',
  //     productCategory: 'Grains',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   // Herbs
  //   ProductModel(
  //     id: 'Asparagus',
  //     title: 'Asparagus',
  //     price: 6.99,
  //     salePrice: 4.99,
  //     imageUrl: 'https://i.ibb.co/RYRvx3W/Asparagus.png',
  //     productCategory: 'Herbs',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Brokoli',
  //     title: 'Brokoli',
  //     price: 0.99,
  //     salePrice: 0.89,
  //     imageUrl: 'https://i.ibb.co/KXTtrYB/Brokoli.png',
  //     productCategory: 'Herbs',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Buk-choy',
  //     title: 'Buk-choy',
  //     price: 1.99,
  //     salePrice: 0.99,
  //     imageUrl: 'https://i.ibb.co/MNDxNnm/Buk-choy.png',
  //     productCategory: 'Herbs',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Chinese-cabbage-wombok',
  //     title: 'Chinese-cabbage-wombok',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/7yzjHVy/Chinese-cabbage-wombok.png',
  //     productCategory: 'Herbs',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Kangkong',
  //     title: 'Kangkong',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/HDSrR2Y/Kangkong.png',
  //     productCategory: 'Herbs',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Leek',
  //     title: 'Leek',
  //     price: 0.99,
  //     salePrice: 0.5,
  //     imageUrl: 'https://i.ibb.co/Pwhqkh6/Leek.png',
  //     productCategory: 'Herbs',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Spinach',
  //     title: 'Spinach',
  //     price: 0.89,
  //     salePrice: 0.59,
  //     imageUrl: 'https://i.ibb.co/bbjvgcD/Spinach.png',
  //     productCategory: 'Herbs',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Almond',
  //     title: 'Almond',
  //     price: 8.99,
  //     salePrice: 6.5,
  //     imageUrl: 'https://i.ibb.co/c8QtSr2/almand.jpg',
  //     productCategory: 'Nuts',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  // ];

 List<ProductModel> _productsList = [];
 List<ProductModel> _searchList = [];
  // get the list of products
 List<ProductModel> get getSearchList => _searchList;
  // get the list of products
 List<ProductModel> get getProducts => _productsList;
  // get the list of products that are on sale
  List<ProductModel> get getOnSaleProducts{
    return _productsList.where((element) => element.isOnSale).toList();
  }
   // fetch products
  Future<List<ProductModel>> fetchProducts() async{
    final ProdService _service = ProdService();
    var prod = await _service.getProduct();
    //print('${prod} ');
    if (prod is List<ProductModel>){
      _productsList = prod;
    }
   //print('${_productsList} ');
    notifyListeners();
    return _productsList;
  }

  // Method to navigate to the next screen
  ProductModel findProdById(String productId){
    return _productsList.firstWhere((element) => element.id == productId, orElse: () => null as ProductModel);
  }
  // Find products by category
  List<ProductModel> findByCategory(String categoryName){
    return _productsList.where((element) => element.productCategory.toLowerCase().contains(categoryName.toLowerCase())).toList();
  }

  // Search for products
  void searchQuery(String searchText){
    List<ProductModel> _list = _productsList.where((element) => element.title.toLowerCase().contains(searchText.toLowerCase())).toList();
    _searchList = _list;
    notifyListeners();
  }
  
}