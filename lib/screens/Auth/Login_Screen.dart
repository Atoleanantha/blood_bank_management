
import 'package:blood_bank_management/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/Utils.dart';
import '../Widgets/round_button.dart';
import 'SignUp_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>(); //check field empty or not
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _Auth=FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _Auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Utils().toastMassage(value.user!.email.toString());
      Utils().toastMassage("Successful Login!!");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>HomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString()); //for removing debug mode statements
      Utils().toastMassage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Sign In",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),),
              const SizedBox(height: 10,),
              SizedBox(
                  height: 100,
                  width: 100,
                  child:  Image.asset('assets/blood.png')
              ),
              const Text("Blood Bank",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),),
              const SizedBox(height: 20,),
              Form(
                  key: _formkey, //check field empty or not
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "*Email",
                            prefixIcon: Icon(Icons.email_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
              RoundBotton(
                  btnName: "Login",
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      login();
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const SignUpScreen()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ]),
                  TextButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeIndex()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_Password_Screen()));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                      child: Text(
                    "Continue with phone",
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
