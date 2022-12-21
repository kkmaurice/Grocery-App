import 'package:delivery/inner_screens/product_details.dart';
import 'package:delivery/models/product_models.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/heart_btn.dart';
import 'package:delivery/widgets/price_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FeedsWidget extends StatefulWidget {
   FeedsWidget({
    Key? key,
  }) : super(key: key);

 

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final TextEditingController _quantityController = TextEditingController();

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

     final product = context.watch<ProductModel>();
     

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetails.routeName, arguments: product.id);
            // GlobalMethods.navigateTo(
            //     context: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FancyShimmerImage(
                  imageUrl: product.imageUrl,
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
                    Flexible(
                        flex: 3,
                        child: TextWidget(
                          text: product.title,
                          color: color,
                          textSize: 18,
                          maxLines: 1,
                          isTitle: true,
                        )),
                    const Flexible(flex: 1, child: HeartBTN())
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: PriceWidget(
                        price: product.price,
                        textPrice: _quantityController.text,
                        isOnSale: product.isOnSale,
                        salePrice: product.salePrice),
                  ),
                  // const SizedBox(width: 8),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 6,
                          child: FittedBox(
                            child: TextWidget(
                                text: product.isPiece? 'Piece' : 'KG',
                                color: color,
                                textSize: 18,
                                isTitle: true),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            child: TextFormField(
                          controller: _quantityController,
                          key: const ValueKey('10'),
                          style: TextStyle(color: color, fontSize: 18),
                          keyboardType: TextInputType.number,
                          
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityController.text = '1';
                              } else {
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
                  onPressed: (() {}),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))))),
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
