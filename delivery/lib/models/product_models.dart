import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String productCategory;
  final double price;
  final double salePrice;
  final bool isOnSale;
  final bool isPiece;
  ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productCategory,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isPiece,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'],
      title: data['title'],
      imageUrl: data['imageUrl'],
      productCategory: data['productName'],
      price: data['price'],
      salePrice: double.parse(data['salePrice'].toString()),
      isOnSale: data['isOnSale'],
      isPiece: data['isPiece'],
    );
  }

  @override
  String toString() {
    return 'title: $title, imgUrl: $imageUrl, prdCategory: $productCategory, price: $price, salePrice: $salePrice, isOnSale: $isOnSale, isPiece: $isPiece';
  }
}
