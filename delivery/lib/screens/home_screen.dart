import 'package:delivery/provider/dartk_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = context.read<DarkThemeProvider>();
    return Scaffold(
      body: Center(
        child: SwitchListTile(
          title: const Text('Theme'),
          secondary: Icon(themeState.getDarkTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
          value: themeState.getDarkTheme, 
          onChanged: (value) {
            setState(() {
              themeState.setDarkTheme = value;
            });
          }),
      ),
    );
  }
}