// ignore_for_file: unnecessary_null_comparison

import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  HeartBTN({
    Key? key,
    required this.productId,
    this.isInWishlist = false
  }) : super(key: key);

 final String productId;
 bool? isInWishlist;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;

    return GestureDetector(
      onTap: () {
        final User? user = authInstance.currentUser;
        if(user == null){
          GlobalMethods.errorDialog(subtitle: 'No user found, Please login first', context: context);
          return;
        }
        context.read<WishListProvider>().addRemoveProductToWishlist(productId);
      },
      child: Icon(
        isInWishlist !=null && isInWishlist == true ? IconlyBold.heart : IconlyLight.heart,
        size: 32,
        color: isInWishlist !=null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
