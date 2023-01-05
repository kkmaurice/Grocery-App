import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../inner_screens/product_details.dart';
import '../../models/orders_model.dart';
import '../../services/utils.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final orderModel = context.watch<OrderModel>();
    var orderDate = orderModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    final orderModel = context.watch<OrderModel>();

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
          imageUrl: orderModel.imageUrl,
          boxFit: BoxFit.fill,
        ),
      ),
      title: TextWidget(text: '${orderModel.title} x${orderModel.quantity}', color: color, textSize: 18, isTitle: true,),
      subtitle: TextWidget(text: '\$${orderModel.price}', color: color, textSize: 15),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 22)
    );
  }
}
