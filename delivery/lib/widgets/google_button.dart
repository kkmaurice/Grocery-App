import 'package:delivery/consts/firebase_consts.dart';
import 'package:delivery/screens/btm_bar.dart';
import 'package:delivery/services/global_methods.dart';
import 'package:delivery/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn(context) async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if(googleAccount != null){
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken !=null){
        try{ 
          // await authInstance.signInWithCredential(
          //   GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken)
          // );
          final User? user = authInstance.currentUser;
          await user!.reauthenticateWithCredential(GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => BottomBarScreen())));
      }on FirebaseException catch(error){
        GlobalMethods.errorDialog(subtitle: '${error.message}', context: context);
      }catch(error){
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
      }finally{

      }
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
         // _googleSignIn(context);
         signInWithGoogle();
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