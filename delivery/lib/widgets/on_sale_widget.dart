import 'package:delivery/inner_screens/product_details.dart';
import 'package:delivery/models/product_models.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/price_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {

    final theme = Utils(context: context).getTheme;
    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;

    final onSaleproduct = context.watch<ProductModel>();
    final cartProvider = context.read<CartProvider>();


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: onSaleproduct.id);
            // GlobalMethods.navigateTo(context: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: onSaleproduct.imageUrl,
                      height: size.height*0.10,
                      width: size.width*0.22,
                      boxFit: BoxFit.fill,
                      ),
                    Column(
                      children: [
                        TextWidget(
                          text: onSaleproduct.isPiece ? '1Piece' : '1KG', 
                        color: color, 
                        textSize: 20, 
                        isTitle: true,),
                        const SizedBox(height: 6,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                              cartProvider.addProductsToCart(onSaleproduct.id, 1);  
                              },
                              child: Icon(
                                IconlyBold.bag2,
                                size: 32,
                                color: color,
                              ),
                            ),
                            const HeartBTN()
                          ],
                        ),
                         
                      ],
                    )
                  ],
                ),
                  PriceWidget(
                  price: onSaleproduct.price, 
                  textPrice: '1', 
                  isOnSale: true, 
                  salePrice: onSaleproduct.salePrice),
                 const SizedBox(height: 5,),
                 TextWidget(
                  text: onSaleproduct.title, 
                  color: color, textSize: 16, 
                  isTitle: true,)
              ],
            ),
            ),
        ),
      ),
    );
  }
}