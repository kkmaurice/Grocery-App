// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers
import 'package:badges/badges.dart' as bg;
import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/providers/cart_provider.dart';
import 'package:delivery/providers/product_provider.dart';
import 'package:delivery/screens/categories.dart';
import 'package:delivery/screens/home_screen.dart';
import 'package:delivery/screens/user.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dartk_theme_provider.dart';
import 'cart/cart_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Home Screen'},
    {'page': const CategoryScreen(), 'title': 'Category Screen'},
    {'page': const CartScreen(), 'title': 'Cart Screen'},
    {'page': const UserScreen(), 'title': 'User Screen'}
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.read<DarkThemeProvider>();
    bool _isDark = themeState.getDarkTheme;

    final cartProvider = context.watch<CartProvider>();
    final cart = cartProvider.getCartItems.values.toList();
    final productProvider = context.watch<ProductProvider>();

    final User? user = authInstance.currentUser;

    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          backgroundColor:
              _isDark ? Colors.cyan.shade900 : Colors.black38.withOpacity(0.5),
          unselectedItemColor: _isDark ? Colors.white : Colors.white,
          selectedItemColor: _isDark ? Colors.indigo.shade900 : Colors.black87,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: bg.Badge(
                    toAnimate: true,
                    shape: bg.BadgeShape.circle,
                    badgeColor: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    position: bg.BadgePosition.topEnd(top: -7, end: -7),
                    
                 
                    badgeContent: FittedBox(
                        child: FutureBuilder(
                            future: user == null? productProvider.fetchProducts() : cartProvider.fetchCart(),
                            builder: ((context, snapshot) {
                              return TextWidget(
                                  text: '${cart.length}',
                                  color: Colors.white,
                                  textSize: 14);
                            }))),
                    child: Icon(_selectedIndex == 2
                        ? IconlyBold.buy
                        : IconlyLight.buy)),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: 'User')
          ]),
    );
  }
}
