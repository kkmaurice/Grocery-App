import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../inner_screens/product_details.dart';
import '../../services/utils.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            GlobalMethods.navigateTo(
                context: context, routeName: ProductDetails.routeName);
          },
          child: Container(
            height: size.height * 0.20,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: color, width: 1),
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: size.width * 0.25,
                  height: size.height * 0.15,
                  child: FancyShimmerImage(
                    imageUrl:
                        'https://media.istockphoto.com/id/182892715/photo/close-up-of-a-yellow-red-apricot-isolated-on-white.jpg?b=1&s=170667a&w=0&k=20&c=Qig2N65afkqn7byIySmpENKVyWm0jDLULKs5vwx5v00=',
                    boxFit: BoxFit.fill,
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: (() {}),
                              icon: Icon(
                                IconlyLight.bag2,
                                color: color,
                              )),
                          const HeartBTN()
                        ],
                      ),
                    ),
                    Flexible(child: TextWidget(text: 'Title', color: color, textSize: 20, maxLines:2, isTitle: true,)),
                    const SizedBox(height: 5,),
                    Flexible(child: TextWidget(text: '\$2.59', color: color, textSize: 18, maxLines:2, isTitle: true,))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
