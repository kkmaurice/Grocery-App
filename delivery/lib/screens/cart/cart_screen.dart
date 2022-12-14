import 'package:delivery/screens/cart/cart_widget.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;
    
    return  Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Cart(2)', color: color, textSize: 22, isTitle: true),
        actions: [
          IconButton(
            onPressed: (() {
              
            }), 
            icon: Icon(IconlyBroken.delete, color: color,))
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          _checkout(context: context),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return const CartWidget();
              })
              ),
          ),
        ],
      )
    );
  }

  Widget _checkout({required BuildContext context}){

    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;

    return SizedBox(
            width: double.infinity,
            height: size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(text: 'Order Now', color: Colors.white, textSize: 20),
                      ),
                    ),
                  ),
                  FittedBox(child: TextWidget(text: 'Total: \$0.44', color: color, textSize: 18, isTitle: true,))
                ],
              ),
            ),
          );
  }
}