// ignore_for_file: dead_code, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/screens/wishlist/wishlist_widget.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_consts.dart';
import '../../services/global_methods.dart';
import '../../widgets/empty_screen.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  static const routeName = '/wish_list_screen';

  @override
  Widget build(BuildContext context) {
    //final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;
    final wishlistProvider = context.watch<WishListProvider>();
    final wishList = context
        .watch<WishListProvider>()
        .getWishlistItems
        .values
        .toList()
        .reversed
        .toList();
final User? user = authInstance.currentUser;
    return  FutureBuilder(
      future: user == null ? context.watch<ProductProvider>().fetchProducts() : wishlistProvider.fetchWishlist(),
      builder: (context, snapshot) {
       return wishList.isEmpty
          ? SafeArea(
              child: EmptyScreen(
                  buttontext: 'Add a wish',
                  imagePath: 'assets/images/wishlist.png',
                  title: 'Your wishlist is empty',
                  subtitle: 'Explore more and shortlist some items'),
            )
          : Scaffold(
              appBar: AppBar(
                leading: const BackWidget(),
                title: TextWidget(
                    text: 'Wishlist (${wishList.length})',
                    color: color,
                    textSize: 22,
                    isTitle: true),
                actions: [
                  IconButton(
                      onPressed: (() {
                        GlobalMethods.warningDialog(
                            title: 'Empty your wishlist',
                            subtitle: 'Are you sure?',
                            fct: () async{
                             await wishlistProvider.clearWishlist();
                              Navigator.of(context).pop();
                            },
                            context: context);
                      }),
                      icon: const Icon(
                        IconlyBroken.delete,
                        color: Colors.red,
                      )),
                  const SizedBox(
                    width: 10,
                  )
                ],
                elevation: 0,
                centerTitle: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              body: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: wishList.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: wishList[index], child: const WishListWidget());
            }));}
    );
  }
}
