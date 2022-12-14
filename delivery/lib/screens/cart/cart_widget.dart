import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../inner_screens/product_details.dart';
import '../../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  final TextEditingController _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;

    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(context: context, routeName: ProductDetails.routeName);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 4,right: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.10,
                        width: size.width * 0.3,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(12)),
                        child: FancyShimmerImage(
                          imageUrl:
                              'https://media.istockphoto.com/id/182892715/photo/close-up-of-a-yellow-red-apricot-isolated-on-white.jpg?b=1&s=170667a&w=0&k=20&c=Qig2N65afkqn7byIySmpENKVyWm0jDLULKs5vwx5v00=',
                          boxFit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Title',
                          color: color,
                          textSize: 20,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              _quantityController(fct: (){
                                if(_quantityTextController.text == '1'){
                                  return;
                                }else{
                                  setState(() {
                                    _quantityTextController.text = (int.parse(_quantityTextController.text) - 1).toString();
                                  });
                                }
                              }, icon: CupertinoIcons.minus, color: Colors.red),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide())
                                  ),
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      if(value.isEmpty){
                                        _quantityTextController.text = '1';
                                      }else{
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                fct: (){
                                  setState(() {
                                    _quantityTextController.text = (int.parse(_quantityTextController.text) + 1).toString();
                                  });
                                }, 
                                icon: CupertinoIcons.add, color: Colors.green)
                            ],
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Icon(
                                CupertinoIcons.cart_badge_minus,
                                color: Colors.red,
                                size: 20,
                                ),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const HeartBTN(),
                          TextWidget(text: '\$0.29', color: color, textSize: 18, maxLines: 1)
                        ],
                      ),
                      ),
                      const SizedBox(width: 7,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityController({ required Function fct, required IconData icon, required Color color }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
