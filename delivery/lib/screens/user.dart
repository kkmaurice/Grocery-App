// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/screens/Auth/forgot_password.dart';
import 'package:delivery/screens/Auth/login.dart';
import 'package:delivery/screens/orders/order_screen.dart';
import 'package:delivery/screens/viewed_recently/viewed_recently.dart';
import 'package:delivery/screens/wishlist/wishlist_screen.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dartk_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  final User? user = authInstance.currentUser;

  @override
  Widget build(BuildContext context) {
    final themeState = context.read<DarkThemeProvider>();
    final color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Hi,  ',
                          style: const TextStyle(
                              color: Colors.cyan,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: 'MyName',
                          style: TextStyle(
                              color: color,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => print('my name is '),
                        )
                      ])),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                      text: 'adonyomaurice@gmail.com',
                      color: color,
                      textSize: 18),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Future.delayed(Duration.zero, () async {
                        await _showAddressDialog();
                      });
                    },
                    child: _listTile(
                        title: 'Address',
                        subtitle: 'My subtitle',
                        icon: IconlyBold.activity,
                        color: color,
                        onPressed: () {}),
                  ),
                  ListTile(
                    title: TextWidget(
                      text: 'Orders',
                      color: color,
                      textSize: 22,
                      //isTitle: true,
                    ),
                    subtitle: TextWidget(text: '', color: color, textSize: 18),
                    leading: const Icon(IconlyLight.bag2),
                    trailing: const Icon(IconlyLight.arrowRight2),
                    onTap: () {
                      Navigator.pushNamed(context, OrderScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: TextWidget(
                      text: 'Whishlist',
                      color: color,
                      textSize: 22,
                      //isTitle: true,
                    ),
                    subtitle: TextWidget(text: '', color: color, textSize: 18),
                    leading: const Icon(IconlyLight.heart),
                    trailing: const Icon(IconlyLight.arrowRight2),
                    onTap: () {
                      Navigator.pushNamed(context, WishList.routeName);
                    },
                  ),
                  ListTile(
                    title: TextWidget(
                      text: 'Viewed',
                      color: color,
                      textSize: 22,
                      //isTitle: true,
                    ),
                    subtitle: TextWidget(text: '', color: color, textSize: 18),
                    leading: const Icon(IconlyLight.show),
                    trailing: const Icon(IconlyLight.arrowRight2),
                    onTap: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: TextWidget(
                      text: 'Forgot password',
                      color: color,
                      textSize: 22,
                      //isTitle: true,
                    ),
                    subtitle: TextWidget(text: '', color: color, textSize: 18),
                    leading: const Icon(IconlyLight.unlock),
                    trailing: const Icon(IconlyLight.arrowRight2),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const ForgotPassword())));
                    },
                  ),
                  SwitchListTile(
                      title: TextWidget(
                          text: themeState.getDarkTheme
                              ? 'Dark mode'
                              : 'Light mode',
                          color: color,
                          textSize: 22),
                      secondary: Icon(themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                      value: themeState.getDarkTheme,
                      onChanged: (value) {
                        setState(() {
                          themeState.setDarkTheme = value;
                        });
                      }),
                  GestureDetector(
                    onTap: () {
                      if(user != null){
                        Future.delayed(Duration.zero, () async {
                        await GlobalMethods.warningDialog(
                            title: 'Sign out',
                            subtitle: 'Do you wanna sign out?',
                            fct: () async{
                              await authInstance.signOut();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const LoginScreen())));
                            },
                            context: context);
                      });
                      }else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                      }
                      
                    },
                    child: _listTile(
                        title: user == null ? 'Login' : 'Logout',
                        icon: user == null
                            ? IconlyBold.login
                            : IconlyLight.logout,
                        color: color,
                        onPressed: () { }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              controller: _addressController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: 'Your address'),
              onChanged: (value) {
                _addressController.text = value;
                _addressController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _addressController.text.length));
              },
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('update'))
            ],
          );
        });
  }

  Widget _listTile(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Color color,
      required Function onPressed}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        //isTitle: true,
      ),
      subtitle: TextWidget(text: subtitle ?? '', color: color, textSize: 18),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: onPressed(),
    );
  }
}
