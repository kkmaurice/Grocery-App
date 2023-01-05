import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/orders_list.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart';
import '../responsive.dart';
import '../widgets/side_menu.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuController>().getOrdersScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      showTexField: false,
                      fct: () {
                      context.read<MenuController>().controlAllOrder();
                    },
                    title: 'All orders',
                    ),
                    const SizedBox(height: 25,),
                     const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: OrdersList(isInDashboard: false,)
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}