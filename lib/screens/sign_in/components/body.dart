import 'package:flutter/material.dart';
import 'package:furniture_app/components/no_account_text.dart';
import 'package:furniture_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
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
                  SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/Phone.svg",
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
}
