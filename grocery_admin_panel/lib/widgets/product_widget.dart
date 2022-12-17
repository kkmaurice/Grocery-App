import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
          onTap: (() {}),
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
                          'https://media.istockphoto.com/id/1159003963/photo/apricot-isolate-apricots-with-slice-on-white-fresh-apricots-with-clipping-path-full-depth-of.jpg?b=1&s=170667a&w=0&k=20&c=Rajx8ONGapWt5xgB6z0MST20Bu04e40CSAICF8b3N8U=',
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
                      text: '\$1.99',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          '\$3.89',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: '1Kg',
                      color: color,
                      textSize: 18,
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: 'Title',
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
