import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/price_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({super.key});

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    _quantityController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final Color color = Utils(context: context).color;
    final size = Utils(context: context).getScreenSize;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FancyShimmerImage(
                  imageUrl:
                      'https://media.istockphoto.com/id/182892715/photo/close-up-of-a-yellow-red-apricot-isolated-on-white.jpg?b=1&s=170667a&w=0&k=20&c=Qig2N65afkqn7byIySmpENKVyWm0jDLULKs5vwx5v00=',
                  height: size.height * 0.10,
                  width: size.width * 0.24,
                  boxFit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: 'Title', color: color, textSize: 20, isTitle: true,),
                    const HeartBTN()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Flexible(
                    flex: 2,
                     child: PriceWidget(
                      price: 5.99, 
                      textPrice: _quantityController.text, 
                      isOnSale: true, 
                      salePrice: 4.22),
                   ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Row(
                      children: [
                        TextWidget(text: 'KG', color: color, textSize: 18, isTitle: true),
                        const SizedBox(width: 5,),
                        Flexible(
                          child: TextFormField(
                            controller: _quantityController,
                            key: const ValueKey('10'),
                            style: TextStyle(color: color, fontSize: 18),
                            keyboardType: TextInputType.number,
                            //maxLength: 1,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty){
                                  _quantityController.text = '1';
                                }else{
                                 // total = usedPrice*int.parse(_quantityController.text);
                                }
                              });
                            },
                          ))
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (() {
                  
                }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)
                        )
                      )
                    )
                  ), 
                child: TextWidget(
                  text: 'Add to cart', 
                  maxLines: 1,
                  color: color, 
                  textSize: 20),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
