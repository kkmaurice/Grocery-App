import 'package:card_swiper/card_swiper.dart';
import 'package:delivery/screens/Auth/login.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../consts/contss.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/google_button.dart';
import '../../widgets/text_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  static const routeName = '/register_screen';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _emailTextController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _fullNameController.dispose();
    _addressTextController.dispose();
    _addressFocusNode.dispose();
    _passFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnRegister() {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    height: 110,
                  ),
                  TextWidget(
                      text: 'Welcome',
                      color: Colors.white,
                      textSize: 30,
                      isTitle: true),
                  const SizedBox(
                    height: 15,
                  ),
                  TextWidget(
                      text: 'Sign up to continue',
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
                                .requestFocus(_emailFocusNode),
                            controller: _fullNameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your full name';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Full name',
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
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>  FocusScope.of(context)
                                .requestFocus(_addressFocusNode),
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
                          const SizedBox(height: 17,),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () => _submitFormOnRegister(),
                            controller: _addressTextController,
                            keyboardType: TextInputType.streetAddress,
                            validator: (value) {
                              if (value!.length < 8) {
                                return 'Please enter a valid address';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Shipping address',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: (() {}),
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
                  AuthButton(fct: () {}, buttonText: 'Sign up'),
                  const SizedBox(
                    height: 15,
                  ),
                  
                  RichText(
                    text: TextSpan(
                        text: 'Already a user?',
                        style: const TextStyle(color: Colors.white, fontSize: 22),
                        children: [
                          TextSpan(
                              text: '  Sign in',
                              style: const TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
    );
  }
}