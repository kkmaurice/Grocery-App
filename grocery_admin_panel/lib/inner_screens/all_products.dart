import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart';
import '../responsive.dart';
import '../screens/dashboard_screen.dart';
import '../widgets/grid_products.dart';
import '../widgets/side_menu.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuController>().getgridscaffoldKey,
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
                      fct: () {
                      context.read<MenuController>().controlProductsMenu();
                    },
                    title: 'All products',
                    ),
                    const SizedBox(height: 25),
                    Responsive(
                      mobile: ProductGridWidget(
                          crossAxisCount: size.width < 750 ? 2 : 4,
                          childAspectRatio: size.width < 1400 ? 0.9 : 1.08,
                          isInMain: false,
                          ),
                      desktop: ProductGridWidget(
                          crossAxisCount: size.width < 750 ? 2 : 4,
                          childAspectRatio: size.width < 1400 ? 0.8 : 1.08,
                         isInMain: false,
                          ),
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