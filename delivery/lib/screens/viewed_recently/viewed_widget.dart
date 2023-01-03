import 'package:delivery/models/viewed_model.dart';
import 'package:delivery/providers/cart_provider.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_consts.dart';
import '../../inner_screens/product_details.dart';
import '../../services/cart_service.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedWidget extends StatelessWidget {
  const ViewedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    final viewedModel = context.watch<ViewedRecently>();
    final productProvider = context.watch<ProductProvider>();
    final viewedCurr = productProvider.findProdById(viewedModel.productId);

    final cartProvider = context.watch<CartProvider>();
    bool? isInCart = cartProvider.getCartItems.containsKey(viewedCurr.id);

    final usedPrice =
        viewedCurr.isOnSale ? viewedCurr.salePrice : viewedCurr.price;

    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetails.routeName,
            arguments: viewedModel.productId);
      },
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        width: size.width * 0.25,
        height: size.height * 0.15,
        child: FancyShimmerImage(
          imageUrl: viewedCurr.imageUrl,
          boxFit: BoxFit.fill,
        ),
      ),
      title: TextWidget(
        text: viewedCurr.title,
        color: color,
        textSize: 18,
        isTitle: true,
      ),
      subtitle: TextWidget(
          text: '\$${usedPrice.toStringAsFixed(2)}',
          color: color,
          textSize: 14),
      trailing: Material(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            final User? user = authInstance.currentUser;
            if (user == null) {
              GlobalMethods.errorDialog(
                  subtitle: 'No user found, Please login first',
                  context: context);
              return;
            }
            CartService().addToCart(viewedCurr.id, 1, context);
            //cartProvider.addProductsToCart(viewedCurr.id, 1);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              isInCart ? IconlyBold.plus : Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
