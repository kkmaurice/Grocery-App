import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OrderModel with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String userName;
  final String price;
  final String total;
  final String title;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;
  OrderModel({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.userName,
    required this.price,
    required this.total,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      orderId: data['orderId'],
      userId: data['userId'],
      productId: data['productId'],
      userName: data['userName'],
      price: double.parse(data['price'].toString()).toStringAsFixed(2),
      title: data['title'],
      imageUrl: data['imageUrl'],
      quantity: double.parse(data['quantity'].toString()).toStringAsFixed(0),
      total: double.parse(data['total'].toString()).toStringAsFixed(2),
      orderDate: data['orderDate'],
    );
  }

  @override
  String toString() {
    return 'orderId: $orderId, userId: $userId, productId: $productId, userName: $userName, price: $price, imageUrl: $imageUrl, quantity: $quantity, orderDate: $orderDate';
  }
}
