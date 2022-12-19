import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/widgets/orders_list.dart';

import 'product_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    Key? key,
    this.crossAxisCount = 1,
    required this.childAspectRatio,
    this.isInMain = true,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: isInMain ? 4 : 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding),
            itemBuilder: (context, index) {
              return const ProductWidget();
            }),
           // const OrdersList()
      ],
    );
  }
}
