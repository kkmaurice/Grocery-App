import 'package:delivery/models/cart_model.dart';
import 'package:delivery/providers/cart_provider.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    Key? key,
    required this.quantity,
  }) : super(key: key);
  final int quantity;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = widget.quantity.toString();
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

    final productProvider = context.watch<ProductProvider>();
    final cartModel = context.watch<CartModel>();
    final getCurrentProduct = productProvider.findProdById(cartModel.productId);
    final wishListProvider = context.watch<WishListProvider>();
    final double usedPrice = getCurrentProduct.isOnSale ? getCurrentProduct.salePrice: getCurrentProduct.price;
     bool? isInWishlist = wishListProvider.getWishlistItems.containsKey(getCurrentProduct.id);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: cartModel.productId);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.10,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: FancyShimmerImage(
                          imageUrl: getCurrentProduct.imageUrl,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: getCurrentProduct.title,
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                  fct: () {
                                    if(_quantityTextController.text=='1'){
                                      return;
                                    }else{
                                      context.read<CartProvider>().decreaseQuantityByOne(cartModel.productId);
                                     setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) -
                                                    1)
                                                .toString();
                                      }); 
                                    }
                                    },
                                  icon: CupertinoIcons.minus,
                                  color: Colors.red),
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
                              _quantityController(
                                  fct: () {
                                    context.read<CartProvider>().increaseQuantityByOne(cartModel.productId);
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  icon: CupertinoIcons.add,
                                  color: Colors.green)
                            ],
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async{
                             await context.read<CartProvider>().removeOneItem(cartModel.id, cartModel.productId, cartModel.quantity);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(
                                CupertinoIcons.cart_badge_minus,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           HeartBTN(
                            productId: getCurrentProduct.id,
                            isInWishlist: isInWishlist,
                            ),
                          TextWidget(
                              text: '\$${(usedPrice * int.parse(_quantityTextController.text)).toStringAsFixed(1)}',
                              color: color,
                              textSize: 18,
                              maxLines: 1)
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
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
              padding: const EdgeInsets.all(6.0),
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
