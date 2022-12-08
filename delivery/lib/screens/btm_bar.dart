// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:delivery/screens/cart.dart';
import 'package:delivery/screens/categories.dart';
import 'package:delivery/screens/home_screen.dart';
import 'package:delivery/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dartk_theme_provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  
  int _selectedIndex = 0;

  final List _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const UserScreen()
  ];

  void _selectedPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final themeState = context.read<DarkThemeProvider>();
    bool _isDark = themeState.getDarkTheme;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        backgroundColor: _isDark ? Colors.cyan.shade900 : Colors.black38.withOpacity(0.5),
        unselectedItemColor: _isDark ? Colors.white : Colors.white,
        selectedItemColor: _isDark ? Colors.lightBlue.shade900 : Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? IconlyBold.home: IconlyLight.home), 
            label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1 ? IconlyBold.category : IconlyLight.category), 
            label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy), 
            label: 'Cart'),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2), 
            label: 'User')
        ]
        ),
    );
  }
}