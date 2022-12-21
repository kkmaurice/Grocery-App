import 'package:delivery/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmptyCatWidget extends StatelessWidget {
   EmptyCatWidget({super.key, required this.catName});
String catName;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context: context).color;
    return Center(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/box.png'),
          ),
          Text(
            '$catName products not available at this time!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),
          )
        ],
        ),
     )
    );
  }
}