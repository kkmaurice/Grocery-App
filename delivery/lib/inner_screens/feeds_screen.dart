import 'dart:math';

import 'package:delivery/consts/contss.dart';
import 'package:delivery/models/product_models.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/screens/wishlist/wishlist_screen.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/feed_items.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  static const routName = '/view_all';

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    final prod = context.watch<ProductProvider>();
    final products = prod.getProducts;

    // final product = context.watch<ProductModel>();
    // final wishListprovider = context.watch<WishListProvider>();
    // bool? isInWishlist = wishListprovider.getWishlistItems.containsKey(product.id);
    
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(
            text: 'All products', color: color, textSize: 22, isTitle: true),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              IconlyBold.bag2,
              size: 32,
              color: color,
            ),
          ),
          //  HeartBTN(
          //   productId: product.id,
          //   isInWishlist: isInWishlist,
          //   )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: prod.fetchProducts(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 10),
                child: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchTextFocusNode,
                    onChanged: (value) {
                      //setState(() {});
                      prod.searchQuery(value);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.greenAccent, width: 1)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.greenAccent, width: 1)
                      ),
                      hintText: 'What\'s in your mind',
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        onPressed: (() {
                          _searchController.clear();
                          _searchTextFocusNode.unfocus();
                        }), 
                        icon: Icon(
                          Icons.close, 
                          color: _searchTextFocusNode.hasFocus ? Colors.red : color,))
                    ),
                  ),
                ),
              ),
              GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  //crossAxisSpacing: 10,
                  //mainAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: size.width / (size.height*0.6),
                  children: List.generate(_searchController.text.isEmpty? products.length : prod.getSearchList.length, (index) {
                    return ChangeNotifierProvider.value(
                      value: _searchController.text.isEmpty ?  products[index] : prod.getSearchList[index],
                      child: FeedsWidget());
                  }),
                  )
            ],
          ),
        );
        })
      
    );
  }
}
