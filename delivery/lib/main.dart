import 'dart:io';

import 'package:delivery/consts/theme_data.dart';
import 'package:delivery/inner_screens/cat_screen.dart';
import 'package:delivery/inner_screens/feeds_screen.dart';
import 'package:delivery/inner_screens/on_sale_screen.dart';
import 'package:delivery/inner_screens/product_details.dart';
import 'package:delivery/provider/dartk_theme_provider.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/providers/viewed_prod_provider.dart';
import 'package:delivery/providers/whislist_provider.dart';
import 'package:delivery/screens/Auth/forgot_password.dart';
import 'package:delivery/screens/Auth/login.dart';
import 'package:delivery/screens/Auth/register.dart';
import 'package:delivery/screens/btm_bar.dart';
import 'package:delivery/screens/orders/order_screen.dart';
import 'package:delivery/screens/viewed_recently/viewed_recently.dart';
import 'package:delivery/screens/wishlist/wishlist_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: Platform.isWindows ? DefaultFirebaseOptions.web : DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
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
        ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => ViewedProdProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery App',
        theme: Styles.themeData(context.watch<DarkThemeProvider>().getDarkTheme, context),
        home: const BottomBarScreen(),
        routes: {
          OnSaleScreen.routeName: (context) => const OnSaleScreen(),
          FeedsScreen.routName: (context) => const FeedsScreen(),
          ProductDetails.routeName: (context) => const ProductDetails(),
          WishList.routeName: (context) => const WishList(),
          OrderScreen.routeName:(context) => const OrderScreen(),
          ViewedRecentlyScreen.routeName:(context) => const ViewedRecentlyScreen(),
          CategoryScreenProducts.routName:(context) => const CategoryScreenProducts(),
          LoginScreen.routeName:(context) => const LoginScreen(),
          Register.routeName:(context) => const Register(),
          ForgotPassword.routeName:(context) => const ForgotPassword()
        },
      );
      },
      
    );
  }
}

