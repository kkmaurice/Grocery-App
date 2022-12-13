
import 'package:delivery/widgets/text_widget.dart';
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
                        onPressed: () {
                          
                        }),
                  ),
                  _listTile(
                      title: 'Orders',
                      icon: IconlyBold.bag,
                      color: color,
                      onPressed: () {}),
                  _listTile(
                      title: 'Whishlist',
                      icon: IconlyLight.heart,
                      color: color,
                      onPressed: () {}),
                  _listTile(
                      title: 'Viewed',
                      icon: IconlyLight.show,
                      color: color,
                      onPressed: () {}),
                  _listTile(
                      title: 'Forgot password',
                      icon: IconlyLight.unlock,
                      color: color,
                      onPressed: () {}),
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
                      Future.delayed(Duration.zero, () async {
                         await _logOutDialog();
                        });
                    },
                    child: _listTile(
                        title: 'Logout',
                        icon: IconlyLight.logout,
                        color: color,
                        onPressed: () {
                          
                        }),
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
              TextButton(
              onPressed: () {
                
              }, 
              child: const Text('update'))],
          );
        });
  }

  Future<void> _logOutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset('assets/images/warning-sign.png',width: 20,height: 20, fit: BoxFit.fill,),
                const SizedBox(width: 10,),
                const Text('Sign out')
              ],
            ),
            content: const Text('Do you wanna signout?'),
            actions: [
              TextButton(onPressed: () {
                if (Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              }, child: TextWidget(text: 'Cancel', color: Colors.cyan, textSize: 18)),
              TextButton(onPressed: () {}, child: TextWidget(text: 'OK', color: Colors.red, textSize: 18))
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

// Widget _logoutDialog(List<int> listTile, int index) {
//    listTile.forEach((element) {
//     element.
//     });
// }
