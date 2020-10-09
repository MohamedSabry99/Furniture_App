import 'package:flutter/material.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/components/no_account_text.dart';
import 'package:furniture_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
import 'package:furniture_app/components/custom_surfix_icon.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/screens/home/home_screen.dart';


class Body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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
                      DefaultButton(
                        text: "Gmail",
                        press: () {
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                        },
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
}
