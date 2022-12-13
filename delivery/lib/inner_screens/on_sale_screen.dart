import 'package:delivery/widgets/on_sale_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({super.key});

  static const routeName = '/on_sale_screen';

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2, color: color,),
        ),
       backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
       elevation: 0,
       title: TextWidget(text: 'Products on sale', color: color, textSize: 22, isTitle: true),
      ),
        // ignore: dead_code
        body: _isEmpty ? Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('assets/images/box.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No products on sale yet!, Stay tuned', textAlign: TextAlign.center, style: TextStyle(color: color,fontSize: 30, fontWeight: FontWeight.w700),),
              ),
            ],
          )) :  
          // ignore: dead_code
          SingleChildScrollView(
          // ignore: dead_code
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            //crossAxisSpacing: 10,
            //mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: size.width / (size.height * 0.45),
            children: List.generate(16, (index) {
              return const OnSaleWidget();
            }),
          ),
        ),
      
    );
  }
}
