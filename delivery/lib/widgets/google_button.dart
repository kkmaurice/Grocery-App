import 'package:delivery/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          
        },
        child: Row(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset('assets/images/google.png', width: 40,)),
              const SizedBox(width: 8,),
              TextWidget(text: 'Sign in with google', color: Colors.white, textSize: 18)
          ],
        ),
      ),
    );
  }
}