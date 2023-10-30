
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Firebase services/SplashServices.dart';

class Splash_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_Splash_Screen();
}
class _Splash_Screen extends State<Splash_Screen>{

  SplashServices SplashScreen=SplashServices();

  @override
  void initState() {
    super.initState();
    SplashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                child:  Image.asset('assets/blood.png')
            ),
            SizedBox(height: 10,),
            Text("Wel-Come",style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}