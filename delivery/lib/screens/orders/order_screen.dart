import 'package:delivery/screens/orders/order_widget.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../services/utils.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {

    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(text: 'Your orders (2)', color: color, textSize: 22, isTitle: true,),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2,vertical: 6),
                    child: OrderWidget(),
                  );
                }), separatorBuilder: (BuildContext context, int index) { 
                  return Divider(color: color,);
                   },
                ),
            ),
          ],
        ),
    );
  }
}