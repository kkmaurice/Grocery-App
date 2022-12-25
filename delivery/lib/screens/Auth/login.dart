// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:delivery/screens/Auth/forgot_password.dart';
import 'package:delivery/screens/Auth/register.dart';
import 'package:delivery/screens/btm_bar.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/auth_button.dart';
import 'package:delivery/widgets/google_button.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../consts/contss.dart';
import '../../consts/firebase_consts.dart';
import '../loading_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async{
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      try{
        await authInstance.signInWithEmailAndPassword(email: _emailTextController.text.trim(), password: _passTextController.text.trim());
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const BottomBarScreen())));
      } on FirebaseException catch (error){
        GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);
        setState(() {
      _isLoading = false;
    });
      }catch(error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
      } finally {
        setState(() {
          _isLoading =false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              duration: 800,
              autoplayDelay: 8000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Contss.authImagesPaths[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: Contss.authImagesPaths.length,
              autoplay: true,
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    TextWidget(
                        text: 'Welcome Back',
                        color: Colors.white,
                        textSize: 30,
                        isTitle: true),
                    const SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        text: 'Sign in to continue',
                        color: Colors.white,
                        textSize: 18,
                        isTitle: false),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'Please enter a valid email address';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            // Password Form field
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () => _submitFormOnLogin(),
                              controller: _passTextController,
                              focusNode: _passFocusNode,
                              obscureText: _obsecureText,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obsecureText = !_obsecureText;
                                      });
                                    },
                                    child: Icon(
                                      _obsecureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: (() {
                            GlobalMethods.navigateTo(context: context, routeName: ForgotPassword.routeName);
                          }),
                          child: const Text(
                            'Forgot password',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(fct: (){_submitFormOnLogin();}, buttonText: 'Login'),
                    const SizedBox(
                      height: 10,
                    ),
                    const GoogleButton(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextWidget(text: 'OR', color: Colors.white, textSize: 18),
                        const SizedBox(
                          width: 5,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      fct: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BottomBarScreen()));
                      },
                      buttonText: 'Continue as a guest',
                      primary: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: const TextStyle(color: Colors.white, fontSize: 22),
                          children: [
                            TextSpan(
                                text: '  Sign up',
                                style: const TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      GlobalMethods.navigateTo(context: context, routeName: Register.routeName);
                                    }
                                    )
                          ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
