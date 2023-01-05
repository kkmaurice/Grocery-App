// ignore_for_file: dead_code, no_leading_underscores_for_local_identifiers

import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/providers/orders_provider.dart';
import 'package:delivery/screens/orders/order_widget.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../services/utils.dart';
import '../../widgets/empty_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  static const routeName = '/order_screen';

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;
    final orderList = context.watch<OrdersProvider>().getOrders;
    final productProvider = context.watch<ProductProvider>();
    User? user = authInstance.currentUser;

    return FutureBuilder(
      future: user==null? productProvider.fetchProducts() : context.watch<OrdersProvider>().fetchOrders(),
      builder: (context, snapshot) {
       return orderList.isEmpty
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
                  text: 'Your orders (${orderList.length})',
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
                      itemCount: context.watch<OrdersProvider>().getOrders.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                          child: ChangeNotifierProvider.value(
                            value: orderList[index],
                            child: const OrderWidget()),
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
            );}
    );
  }
}
