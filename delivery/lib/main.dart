import 'package:delivery/consts/theme_data.dart';
import 'package:delivery/provider/dartk_theme_provider.dart';
import 'package:delivery/screens/btm_bar.dart';
import 'package:delivery/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePrefs.getTheme(); 
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DarkThemeProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery App',
        theme: Styles.themeData(context.watch<DarkThemeProvider>().getDarkTheme, context),
        home: BottomBarScreen(),
      );
      },
      
    );
  }
}

