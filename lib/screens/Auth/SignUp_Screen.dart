
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/Utils.dart';
import '../Widgets/round_button.dart';
import 'Login_Screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>(); //check field empty or not
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool loading = false;
  final FirebaseAuth _Auth =FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });
    _Auth.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Utils().toastMassage("SignUp successful");
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMassage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //for the exit navigarter button and exit
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Sign Up",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),),
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
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "Name",
                            prefixIcon: Icon(Icons.abc_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: "Email",
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
                      ),
                    ],
                  )),
              RoundBotton(
                  btnName: "Sign Up",
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signup();
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "SignIn",
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
