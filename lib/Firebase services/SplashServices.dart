import 'package:blood_bank_management/screens/Auth/Login_Screen.dart';
import 'package:blood_bank_management/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashServices {


  void isLogin(BuildContext context) {

    FirebaseAuth auth=FirebaseAuth.instance;
    //check the status of user
    final user= auth.currentUser;
    //check user is null or not
    if(user!=null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            // context, MaterialPageRoute(builder: (context) => upload_profile_image()));
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
    else{
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>const LoginScreen()));
      });
    }
  }
}
