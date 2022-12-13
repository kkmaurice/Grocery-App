import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dartk_theme_provider.dart';

class Utils {
  BuildContext context;
  Utils({
    required this.context,
  });

  bool get getTheme => context.watch<DarkThemeProvider>().getDarkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
