// ignore_for_file: avoid_unnecessary_containers

import 'package:delivery/providers/cart_provider.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/providers/viewed_prod_provider.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  static const routeName = '/product_details';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;

    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final getCurrProduct =
        context.watch<ProductProvider>().findProdById(productId);
    final cartProvider = context.watch<CartProvider>();
    final wishListProvider = context.watch<WishListProvider>();

    final double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;

    final double totalPrice =
        usedPrice * int.parse(_quantityTextController.text);
    final String unitText = getCurrProduct.isPiece ? 'Piece' : 'Kg';
    bool? isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    bool? isInWishlist =
        wishListProvider.getWishlistItems.containsKey(getCurrProduct.id);

    return WillPopScope(
      onWillPop: () async {
        context.read<ViewedProdProvider>().addProductToHistory(productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Icon(
                IconlyLight.arrowLeft2,
                color: color,
                size: 22,
              )),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: getCurrProduct.imageUrl,
                boxFit: BoxFit.fill,
              ),
            ),
            Flexible(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: TextWidget(
                                    text: getCurrProduct.title,
                                    color: color,
                                    textSize: 18,
                                    isTitle: true)),
                            HeartBTN(
                              productId: getCurrProduct.id,
                              isInWishlist: isInWishlist,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                                text: '\$${getCurrProduct.salePrice}/',
                                color: Colors.green,
                                textSize: 22,
                                isTitle: true),
                            TextWidget(
                                text: getCurrProduct.isPiece ? 'Piece' : '/Kg',
                                color: color,
                                textSize: 12,
                                isTitle: false),
                            const SizedBox(
                              width: 10,
                            ),
                            Visibility(
                                visible: getCurrProduct.isOnSale ? true : false,
                                child: Text(
                                  '\$${getCurrProduct.price}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: color,
                                      decoration: TextDecoration.lineThrough),
                                )),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(60, 200, 101, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: TextWidget(
                                  text: 'Free delivery',
                                  color: Colors.white,
                                  textSize: 18,
                                  isTitle: true),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _quantityController(
                              fct: () {
                                if (_quantityTextController.text == '1') {
                                  return;
                                } else {
                                  setState(() {
                                    _quantityTextController.text = (int.parse(
                                                _quantityTextController.text) -
                                            1)
                                        .toString();
                                  });
                                }
                              },
                              icon: CupertinoIcons.minus,
                              color: Colors.red),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 1,
                            child: TextField(
                              controller: _quantityTextController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide())),
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextController.text = '1';
                                  } else {
                                    return;
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          _quantityController(
                              fct: () {
                                setState(() {
                                  _quantityTextController.text =
                                      (int.parse(_quantityTextController.text) +
                                              1)
                                          .toString();
                                });
                              },
                              icon: CupertinoIcons.add,
                              color: Colors.green)
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Total',
                                  color: Colors.red.shade300,
                                  textSize: 20,
                                  isTitle: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                    child: Row(
                                  children: [
                                    TextWidget(
                                        text:
                                            '\$${totalPrice.toStringAsFixed(2)}/',
                                        color: color,
                                        textSize: 20,
                                        isTitle: true),
                                    TextWidget(
                                      text:
                                          '${_quantityTextController.text}$unitText',
                                      color: color,
                                      textSize: 16,
                                      isTitle: false,
                                    )
                                  ],
                                ))
                              ],
                            )),
                            Flexible(
                                child: Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  if (isInCart) {
                                    return;
                                  } else {
                                    final User? user = authInstance.currentUser;
                                    if (user == null) {
                                      GlobalMethods.errorDialog(
                                          subtitle:
                                              'No user found, Please login first',
                                          context: context);
                                      return;
                                    }
                                    context
                                        .read<CartProvider>()
                                        .addProductsToCart(
                                            productId,
                                            int.parse(
                                                _quantityTextController.text));
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                      text:
                                          isInCart ? 'In cart' : 'Add to cart',
                                      color: Colors.white,
                                      textSize: 18),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _quantityController(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
