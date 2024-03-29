import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/empty_cat_prd.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../models/product_models.dart';
import '../providers/product_provider.dart';
import '../providers/whislist_provider.dart';
import '../widgets/feed_items.dart';
import '../widgets/heart_btn.dart';

class CategoryScreenProducts extends StatefulWidget {
  const CategoryScreenProducts({super.key});

  static const routName = '/category_screen';

  @override
  State<CategoryScreenProducts> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<CategoryScreenProducts> {
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

    String catName = ModalRoute.of(context)!.settings.arguments as String;

    final prod = context.watch<ProductProvider>();
    final catProducts = prod.findByCategory(catName);

    final product = context.watch<ProductModel>();
    final wishListprovider = context.watch<WishListProvider>();
    bool? isInWishlist =
        wishListprovider.getWishlistItems.containsKey(product.id);

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(
            text: catName, color: color, textSize: 22, isTitle: true),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              IconlyBold.bag2,
              size: 32,
              color: color,
            ),
          ),
          HeartBTN(
            productId: '',
            isInWishlist: isInWishlist,
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: catProducts.isEmpty
          ? EmptyCatWidget(catName: catName)
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, bottom: 8, right: 10),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchTextFocusNode,
                        onChanged: (value) {
                          //setState(() {});
                          context.read<ProductProvider>().searchQuery(value);
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.greenAccent, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.greenAccent, width: 1)),
                            hintText: 'What\'s in your mind',
                            prefixIcon: const Icon(Icons.search),
                            suffix: IconButton(
                                onPressed: (() {
                                  _searchController.clear();
                                  _searchTextFocusNode.unfocus();
                                }),
                                icon: Icon(
                                  Icons.close,
                                  color: _searchTextFocusNode.hasFocus
                                      ? Colors.red
                                      : color,
                                ))),
                      ),
                    ),
                  ),
                  context.watch<ProductProvider>().getSearchList.isEmpty
                      ? const Center(
                          child:
                              Text('No products found, please try another key'),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          //crossAxisSpacing: 10,
                          //mainAxisSpacing: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: size.width / (size.height * 0.6),
                          children: List.generate(_searchController.text.isEmpty ? catProducts.length : prod.getSearchList.length, (index) {
                            return ChangeNotifierProvider.value(
                                value: _searchController.text.isNotEmpty ? prod.getSearchList[index] : catProducts[index],
                                child: FeedsWidget());
                          }),
                        )
                ],
              ),
            ),
    );
  }
}
