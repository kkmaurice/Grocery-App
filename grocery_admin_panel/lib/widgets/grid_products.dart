import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/services/utils.dart';
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
    final Color color = Utils(context).color;
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState== ConnectionState.active){
              if(snapshot.data!.docs.isNotEmpty){
                return  GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: isInMain && snapshot.data!.docs.length >4 ? 4 : snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding),
              itemBuilder: (context, index) {
                return  ProductWidget(id: snapshot.data!.docs[index]['id']);
              });
              } else {
                return const Center(child: Text('No products yet'));
              }
            }
            return const Center(child: Text('Something went wrong',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),));
          },
        ),
           // const OrdersList()
      ],
    );
  }
}
