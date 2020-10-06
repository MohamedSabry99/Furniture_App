
import 'package:flutter/widgets.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/screens/sign_in/sign_in_screen.dart';
import 'package:furniture_app/screens/sign_up/sign_up_screen.dart';
final Map<String, WidgetBuilder> routes={
 HomeScreen.routeName:(context)=>HomeScreen(),
  SignInScreen.routeName:(context)=>SignInScreen(),
  SignUpScreen.routeName:(context)=>SignUpScreen(),
};