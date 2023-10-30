import 'package:blood_bank_management/services/database/DBServices.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'package:flutter/material.dart';

import 'Splash_Screen.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DBServices();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Splash_Screen(),
    );
  }
}
