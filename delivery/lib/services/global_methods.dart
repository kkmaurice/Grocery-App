import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo({required context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> warningDialog(
      {required String title,
      required String subtitle,
      required Function fct,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(title)
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                      text: 'Cancel', color: Colors.cyan, textSize: 18)),
              TextButton(
                  onPressed: () {
                    fct();
                  },
                  child:
                      TextWidget(text: 'OK', color: Colors.red, textSize: 18))
            ],
          );
        });      
  }

  static Future<void> errorDialog(
      {
      required String subtitle,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Error occurred')
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                      text: 'Ok', color: Colors.cyan, textSize: 18)),
            ],
          );
        });      
  }
}
