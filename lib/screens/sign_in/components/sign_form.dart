import 'package:flutter/material.dart';
import 'package:furniture_app/components/custom_surfix_icon.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey=GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  final List<String> errors = [];
  bool remember = false;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          //FormError(errors: errors),
          SizedBox(height: 20),
          DefaultButton(
            text: "Continue",
            press: () {
               if (_formKey.currentState.validate()) {
                 _Signin();
               }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kPassNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      onChanged: (value){
        if(value.isNotEmpty){
          removeError(error: kEmailNullError);
        }else if(emailValidatorRegExp.hasMatch(value)){
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
         addError(error: kEmailNullError);
         return "";
       }else if(!emailValidatorRegExp.hasMatch(value)){
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void _Signin() async{
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text))
          .user;
      if(!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.pushNamed(context, HomeScreen.routeName);
    }catch (e){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Failed to sign in'),
      ));
      print(e);

    }
  }
}
