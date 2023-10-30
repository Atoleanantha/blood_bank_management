
import 'package:blood_bank_management/screens/Auth/Login_Screen.dart';
import 'package:blood_bank_management/screens/HomeScreen.dart';
import 'package:blood_bank_management/services/database/DBServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Simulate a 5-second delay using a Future.
    Future.delayed(const Duration(seconds: 5), () {
      // After 5 seconds, navigate to the HomeScreen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>const LoginScreen(),
        ),
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    DBServices().getConnection();

    return const Scaffold(
      body: Center(

        child: CircularProgressIndicator(), // You can replace this with a custom loading widget.
      ),
    );
  }
}
