import 'package:flutter/material.dart';
import 'package:furniture_app/components/custom_surfix_icon.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../../constants.dart';
import '../../../size_config.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmController=TextEditingController();
  bool remember = false;
  final List<String> errors = [];

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
          buildConformPassFormField(),
          //FormError(errors: errors),
          SizedBox(height: 40),
          DefaultButton(
            text: "Continue",
            press: () async{
              if (_formKey.currentState.validate()) {
                _register();
                // if all are valid then go to success screen
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      controller: _confirmController,
      validator: (value) {
        if (value.isEmpty ) {
          return kPassNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onChanged: (value){
        if(value.isNotEmpty&&_passwordController.text == _confirmController.text){
          removeError(error: kMatchPassError);
        }
        _confirmController.text=value;
      },
      validator: (value) {
        if (value.isEmpty) {
         return kPassNullError;
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
      validator: (value) {
        if (value.isEmpty) {
          return kEmailNullError;
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
  void _register() async{
    final User user=(await _auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text)).user;
    if(user != null){
      if(!user.emailVerified){
        await user.sendEmailVerification();
      }
      await user.updateEmail(_emailController.text);
      await user.updatePassword(_passwordController.text);
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }
}
