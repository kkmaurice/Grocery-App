import 'package:delivery/inner_screens/cat_screen.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dartk_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.catText,
    required this.impPath,
    required this.color,
  }) : super(key: key);

  final String catText;
  final String impPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<DarkThemeProvider>();
    final colors = themeState.getDarkTheme ? Colors.white : Colors.black;
    final _screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          CategoryScreenProducts.routName, arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.withOpacity(0.7), width: 2)),
        child: Column(
          children: [
            Container(
              height: _screenSize.height * 0.2,
              width: _screenSize.width * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(impPath),
                      fit: BoxFit.fill)),
            ),
            TextWidget(
                text: catText, color: colors, textSize: 20, isTitle: true)
          ],
        ),
      ),
    );
  }
}
