
// ignore_for_file: dead_code

import 'package:delivery/providers/viewed_prod_provider.dart';
import 'package:delivery/screens/viewed_recently/viewed_widget.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/empty_screen.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});

  static const routeName = '/viewed_recently_screen';

  @override
  Widget build(BuildContext context) {

    //bool _isEmpty = true;

    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;

    final viewProdProvider = context.watch<ViewedProdProvider>();
    final viewProdItemList = viewProdProvider.getViewedlistItems.values.toList().reversed.toList();

    return viewProdItemList.isEmpty ? Center(
      child: SafeArea(
        child: EmptyScreen(
          buttontext: 'Shop now', 
          imagePath: 'assets/images/history.png', 
          title: 'Your history is empty', 
          subtitle: 'No products has been viewed yet!'),
      ),
    ) : Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(text: 'History', color: color, textSize: 22, isTitle: true,),
        actions: [
          IconButton(
            onPressed: (() {
             GlobalMethods.warningDialog(title: 'Delete history', subtitle: 'Are you sure?', fct: (){}, context: context); 
            }), 
            icon: const Icon(IconlyBroken.delete, color: Colors.red,)),
            const SizedBox(width: 10,)
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: viewProdItemList.length,
                itemBuilder: ((context, index) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: ChangeNotifierProvider.value(
                      value: viewProdItemList[index],
                      child: ViewedWidget()),
                  );
                }), 
                ),
            ),
          ],
        ),
    );
  }
}