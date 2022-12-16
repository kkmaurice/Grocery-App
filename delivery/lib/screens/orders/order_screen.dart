// ignore_for_file: dead_code

import 'package:delivery/screens/orders/order_widget.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../services/utils.dart';
import '../../widgets/empty_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    return _isEmpty
        ? SafeArea(
          child: EmptyScreen(
              buttontext: 'Shop now',
              imagePath: 'assets/images/cart.png',
              title: 'You didn\'t any order',
              subtitle: 'Order something and make me happy :)'),
        )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              title: TextWidget(
                text: 'Your orders (2)',
                color: color,
                textSize: 22,
                isTitle: true,
              ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                        child: OrderWidget(),
                      );
                    }),
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: color,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
