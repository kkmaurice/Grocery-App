import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../inner_screens/product_details.dart';
import '../../services/utils.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    return ListTile(
      onTap: () {
        GlobalMethods.navigateTo(
            context: context, routeName: ProductDetails.routeName);
      },
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        width: size.width * 0.25,
        height: size.height * 0.15,
        child: FancyShimmerImage(
          imageUrl:
              'https://media.istockphoto.com/id/182892715/photo/close-up-of-a-yellow-red-apricot-isolated-on-white.jpg?b=1&s=170667a&w=0&k=20&c=Qig2N65afkqn7byIySmpENKVyWm0jDLULKs5vwx5v00=',
          boxFit: BoxFit.fill,
        ),
      ),
      title: TextWidget(text: 'Title x12', color: color, textSize: 18, isTitle: true,),
      subtitle: TextWidget(text: '\$12.8', color: color, textSize: 15),
      trailing: TextWidget(text: '19/08/2022', color: color, textSize: 22)
    );
  }
}
