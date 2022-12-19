import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/responsive.dart';
import 'package:grocery_admin_panel/services/global_method.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/buttons.dart';

import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/orders_list.dart';
import 'package:grocery_admin_panel/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart';
import '../inner_screens/add_prod.dart';
import '../widgets/grid_products.dart';
import '../widgets/text_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<MenuController>().controlDashboarkMenu();
              },
            ),
            TextWidget(text: 'Latest Products', color: color),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ButtonsWidget(
                      onPressed: () {},
                      text: 'View All',
                      icon: Icons.store,
                      backgroundColor: Colors.blue),
                  const Spacer(),
                  ButtonsWidget(
                      onPressed: () {
                        GlobalMethods.navigateTo(ctx: context, routeName: UploadProductForm.routeName);
                      },
                      text: 'Add product',
                      icon: Icons.store,
                      backgroundColor: Colors.blue),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Responsive(
                      mobile: Column(
                        children: [
                          ProductGridWidget(
                              crossAxisCount: size.width < 750 ? 2 : 4,
                              childAspectRatio: size.width < 1400 ? 0.9 : 1.08),
                          OrdersList()
                        ],
                      ),
                      desktop: Column(
                        children: [
                          ProductGridWidget(
                              crossAxisCount: size.width < 750 ? 2 : 4,
                              childAspectRatio: size.width < 1400 ? 0.8 : 1.08),
                          OrdersList()
                        ],
                      ),
                    )
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
