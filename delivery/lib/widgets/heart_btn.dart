// ignore_for_file: unnecessary_null_comparison

import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/services/wishlist_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatefulWidget {
  HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);

  final String productId;
  bool? isInWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final getCurrProduct = productProvider.findProdById(widget.productId);
    final wishListProvider = context.watch<WishListProvider>();

    final Color color = Utils(context: context).color;

    return FutureBuilder(
        future: wishListProvider.fetchWishlist(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });
              try {
                final User? user = authInstance.currentUser;
                if (user == null) {
                  await GlobalMethods.errorDialog(
                      subtitle: 'No user found, Please login first',
                      context: context);
                  return;
                }
                if (widget.isInWishlist == false &&
                    widget.isInWishlist != null) {
                  await WishListService()
                      .addToWishList(widget.productId, context);
                } else {
                  context.read<WishListProvider>().removeOneItem(
                      wishListProvider.getWishlistItems[getCurrProduct.id]!.id,
                      widget.productId);
                }
                await wishListProvider.fetchWishlist();
                setState(() {
                  _isLoading = false;
                });
              } catch (error) {
                GlobalMethods.errorDialog(subtitle: '$error', context: context);
              }
            },
            child: _isLoading
                ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 20, width: 20,
                    child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  ),
                )
                : Icon(
                    widget.isInWishlist != null && widget.isInWishlist == true
                        ? IconlyBold.heart
                        : IconlyLight.heart,
                    size: 32,
                    color: widget.isInWishlist != null &&
                            widget.isInWishlist == true
                        ? Colors.red
                        : color,
                  ),
          );
        });
  }
}
