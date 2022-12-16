// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../inner_screens/feeds_screen.dart';
import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
   EmptyScreen({
    Key? key,
    required this.buttontext, required this.imagePath, required this.title, required this.subtitle,
  }) : super(key: key);

  final String imagePath, title, subtitle, buttontext;

  @override
  Widget build(BuildContext context) {
    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).color;
    final themestate = Utils(context: context).getTheme;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: size.height * 0.4,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Whoops!',
              style: TextStyle(
                  color: Colors.red, fontSize: 40, fontWeight: FontWeight.w700),
            ),
            TextWidget(
                text: title,
                color: Colors.cyan,
                textSize: 20),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
                text: subtitle,
                color: Colors.cyan,
                textSize: 20),
             SizedBox(
              height: size.height*0.15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    //foregroundColor: color, backgroundColor:
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary)),
                    primary: Theme.of(context).colorScheme.secondary,
                    onPrimary: color,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),
                onPressed: (() {
                  GlobalMethods.navigateTo(
                      context: context, routeName: FeedsScreen.routName);
                }),
                child: TextWidget(
                    text: buttontext,
                    color: themestate?Colors.grey.shade300 :Colors.grey.shade700,
                    textSize: 20,
                    isTitle: true
                    )
                )
          ],
        ),
      )),
    );
  }
}
