import 'package:card_swiper/card_swiper.dart';
import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../consts/contss.dart';
import '../../services/utils.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';
import '../loading_manager.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const routeName = '/forgot_password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailTextController = TextEditingController();
   bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  void _forgetPassFCT() async {
    if(_emailTextController.text.isEmpty || !_emailTextController.text.contains('@')){
      GlobalMethods.errorDialog(subtitle: 'Please enter a correct email address', context: context);
    }else{
      setState(() {
        _isLoading = true;
      });
     try{
        await authInstance.sendPasswordResetEmail(email: _emailTextController.text.toLowerCase());
        Fluttertoast.showToast(
        msg: "An email has been sent to your email address",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0
    );
     }on FirebaseException catch (error){
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
    Size size = Utils(context: context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Contss.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Contss.authImagesPaths.length,
      
              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                      color: Colors.white,
                    ),
                  ),
                  //const BackWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Forget password',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
