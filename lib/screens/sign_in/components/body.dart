import 'package:flutter/material.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/components/no_account_text.dart';
import 'package:furniture_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
import 'dart:async';
import 'package:furniture_app/components/custom_surfix_icon.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';


class Body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                SignForm(),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                        text: "Gmail",
                        press: () {
                          _SignInGoogle();

                        }
                    ),
                    SocalCard(
                      text: "Phone",
                      press: () {},
                    ),

                  ],
                ),
                SizedBox(height: 50),
                NoAccountText(),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Future<UserCredential> _SignInGoogle() async {
    final GoogleSignInAccount googleSignInAccount=await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication=
    await googleSignInAccount.authentication;

    final GoogleAuthCredential credential=GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );
    return await _auth.signInWithCredential(credential);
  }
}