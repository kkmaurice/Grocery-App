import 'package:delivery/screens/wishlist/wishlist_widget.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../services/global_methods.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  static const routeName = '/wish_list_screen';

  @override
  Widget build(BuildContext context) {

    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;
    
    return  Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(text: 'Wishlist (2)', color: color, textSize: 22, isTitle: true),
        actions: [
          IconButton(
            onPressed: (() {
             GlobalMethods.warningDialog(title: 'Empty your wishlist', subtitle: 'Are you sure?', fct: (){}, context: context); 
            }), 
            icon: const Icon(IconlyBroken.delete, color: Colors.red,)),
            const SizedBox(width: 10,)
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        // mainAxisSpacing: 16, 
        // crossAxisSpacing: 4,
        itemBuilder: (context, index){
          return const WishListWidget();
        })
    );
  }
}