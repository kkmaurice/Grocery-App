import 'package:flutter/cupertino.dart';

class ViewedRecently with ChangeNotifier {
  final String id;
  final String productId;

  ViewedRecently({
    required this.id,
    required this.productId,
  });
}