import 'package:delivery/models/product_models.dart';
import 'package:delivery/models/wishlist_model.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../services/utils.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    final wishListModel = context.watch<WishListModel>();
    final productProvider = context.watch<ProductProvider>();
    final wishlistProvider = context.watch<WishListProvider>();
    final wishlistcurr = productProvider.findProdById(wishListModel.productId);

    final double usedPrice = wishlistcurr.isOnSale ? wishlistcurr.salePrice: wishlistcurr.price;
     bool? isInWishlist = wishlistProvider.getWishlistItems.containsKey(wishListModel.productId);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName, arguments: wishListModel.productId);
          },
          child: Container(
            height: size.height * 0.20,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  //width: size.width * 0.25,
                  height: size.height * 0.15,
                  child: FancyShimmerImage(
                    imageUrl: wishlistcurr.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                )),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: (() {
                                 
                                }),
                                icon: Icon(
                                  IconlyLight.bag2,
                                  color: color,
                                )),
                             HeartBTN(
                              productId: wishListModel.productId,
                              isInWishlist: isInWishlist,
                              )
                          ],
                        ),
                      ),
                      TextWidget(text: wishlistcurr.title, color: color, textSize: 20, maxLines:2, isTitle: true,),
                      const SizedBox(height: 5,),
                      Flexible(child: TextWidget(text: '\$${usedPrice.toStringAsFixed(2)}', color: color, textSize: 18, maxLines:2, isTitle: true,))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
