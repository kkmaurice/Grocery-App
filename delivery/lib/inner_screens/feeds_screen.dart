import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/back_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../widgets/feed_items.dart';
import '../widgets/heart_btn.dart';

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
          const HeartBTN()
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchTextFocusNode,
                  onChanged: (value) {
                    setState(() {
                      
                    });
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
                children: List.generate(20, (index) {
                  return const FeedsWidget();
                }),
                )
          ],
        ),
      ),
    );
  }
}
