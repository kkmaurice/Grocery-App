import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/price_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            print('am clicked');
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
                      imageUrl: 'https://media.istockphoto.com/id/182892715/photo/close-up-of-a-yellow-red-apricot-isolated-on-white.jpg?b=1&s=170667a&w=0&k=20&c=Qig2N65afkqn7byIySmpENKVyWm0jDLULKs5vwx5v00=',
                      height: size.height*0.10,
                      width: size.width*0.22,
                      boxFit: BoxFit.fill,
                      ),
                    Column(
                      children: [
                        TextWidget(text: '1KG', color: color, textSize: 22, isTitle: true,),
                        const SizedBox(height: 6,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                
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
                 const PriceWidget(
                  price: 3.45, 
                  textPrice: '1', 
                  isOnSale: true, 
                  salePrice: 2.11),
                 const SizedBox(height: 5,),
                 TextWidget(text: 'Product price', color: color, textSize: 16, isTitle: true,)
              ],
            ),
            ),
        ),
      ),
    );
  }
}