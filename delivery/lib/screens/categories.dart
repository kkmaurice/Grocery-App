import 'package:delivery/services/utils.dart';
import 'package:delivery/widgets/categories_widget.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context: context);
    Color color = utils.color;

    List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

    List<Map<String, dynamic>> catInfo = [
      {'imgPath': 'assets/images/cat/fruits.png', 'catText': 'Fruits'},
      {'imgPath': 'assets/images/cat/veg.png', 'catText': 'Vegetables'},
      {'imgPath': 'assets/images/cat/Spinach.png', 'catText': 'Herbs'},
      {'imgPath': 'assets/images/cat/nuts.png', 'catText': 'Nuts'},
      {'imgPath': 'assets/images/cat/spices.png', 'catText': 'Spices'},
      {'imgPath': 'assets/images/cat/grains.png', 'catText': 'Grains'}
    ];
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: 'Categories', color: color, textSize: 24),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(
              6,
              (index) => CategoriesWidget(
                  catText: catInfo[index]['catText'],
                  impPath: catInfo[index]['imgPath'],
                  color: gridColors[index])),
        ),
      ),
    );
  }
}
