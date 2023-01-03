import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/inner_screens/edit_prod.dart';

import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';

import '../services/global_method.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.id,
  }) : super(key: key);
final  id;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String title = '';
  String productCategory = '';
  String? imageUrl;
  String price = '0.0';
  double salePrice = 0.0;
  bool isOnSale = false;
  bool isPiece = false;

  @override
  void initState() {
    getProductData();
    super.initState();
  }

  Future<void> getProductData() async{
    setState(() {
    });

    try{
      DocumentSnapshot productDoc = await FirebaseFirestore.instance.collection('products').doc(widget.id).get();
      if(productDoc==null){
        return;
      }else{
        setState(() {
          title = productDoc.get('title');
   productCategory = productDoc.get('categoryName');
    imageUrl = productDoc.get('imageUrl');
   price = productDoc.get('price');
   salePrice = productDoc.get('salePrice');
   isOnSale = productDoc.get('isOnSale');
   isPiece = productDoc.get('isPiece');
        });
      }
    }catch (error){
      setState(() {
    });
    GlobalMethods.errorDialog(subtitle: '$error', context: context);
    }finally{
     
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen(
              id: widget.id, 
              title: title, 
              price: price, 
              salePrice: salePrice, 
              productCat: productCategory, 
              imageUrl: imageUrl??'https://i.ibb.co/PcP9xfK/Tomatoes.png', 
              isOnSale: isOnSale, 
              isPiece: isPiece)));
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 3,
                        child: Image.network(
                          imageUrl == null ? 'https://i.ibb.co/PcP9xfK/Tomatoes.png': imageUrl!,
                          fit: BoxFit.fill,
                          height: size.width * 0.12,
                        )),
                    
                    PopupMenuButton(
                        itemBuilder: ((context) => [
                              PopupMenuItem(
                                onTap: () {},
                                child: const Text('Edit'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.red),
                                ),
                                value: 1,
                              )
                            ]))
                  ],
                ),
                Row(
                  children: [
                    TextWidget(
                      text: isOnSale ? '\$$salePrice' : '\$$price',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: isOnSale,
                        child: Text(
                          '\$3.89',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: isPiece ? 'Piece' : 'Kg',
                      color: color,
                      textSize: 18,
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
