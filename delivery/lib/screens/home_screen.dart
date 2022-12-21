import 'package:card_swiper/card_swiper.dart';
import 'package:delivery/inner_screens/feeds_screen.dart';
import 'package:delivery/models/product_models.dart';
import 'package:delivery/provider/dartk_theme_provider.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../consts/contss.dart';
import '../inner_screens/on_sale_screen.dart';
import '../providers/product_provider.dart';
import '../widgets/feed_items.dart';
import '../widgets/on_sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context: context);
    final themeState = utils.getTheme;
    final size = utils.getScreenSize;
    final Color color = utils.color;

    final prod = context.watch<ProductProvider>();
    final products = prod.getProducts;

    final onSaleprod = prod.getOnSaleProducts;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.33,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      Contss.offerImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: Contss.offerImages.length,
                  autoplay: true,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.red)),
                  //control: SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextButton(
                  onPressed: (() {
                    GlobalMethods.navigateTo(
                        context: context, routeName: OnSaleScreen.routeName);
                  }),
                  child: TextWidget(
                      text: 'View all',
                      color: Colors.blue,
                      textSize: 22,
                      maxLines: 1)),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Row(
                      children: [
                        TextWidget(
                            text: 'On sale'.toUpperCase(),
                            color: Colors.red,
                            textSize: 22,
                            isTitle: true),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          IconlyLight.discount,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.22,
                      child: ListView.builder(
                          itemCount:
                              onSaleprod.length < 10 ? onSaleprod.length : 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return ChangeNotifierProvider.value(
                                value: onSaleprod[index],
                                child: const OnSaleWidget());
                          })),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextWidget(
                        text: 'Our products', color: color, textSize: 22),
                    const Spacer(),
                    TextButton(
                        onPressed: (() {
                          GlobalMethods.navigateTo(
                              context: context,
                              routeName: FeedsScreen.routName);
                        }),
                        child: TextWidget(
                            text: 'Browse all',
                            color: Colors.blue,
                            textSize: 22,
                            maxLines: 1)),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                //crossAxisSpacing: 10,
                //mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: size.width / (size.height * 0.6),
                children: List.generate(
                    products.length < 4 ? products.length : 4, (index) {
                  return ChangeNotifierProvider.value(
                      value: products[index], child: FeedsWidget());
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
