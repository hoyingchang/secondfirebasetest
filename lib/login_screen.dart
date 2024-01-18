import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondfirebasetest/register_screen.dart';
import 'package:secondfirebasetest/textfield_widget.dart';

import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  checkUserAlreadyLogin()
  {
    //if user already log in, go to Home Screen directly
    if (firebaseAuth.currentUser != null) {
      print(firebaseAuth.currentUser?.uid);

      Timer(const Duration(seconds:1),()async
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);

      });
    }


  }

  @override
  void initState() {
    // run checkUserAlreadyLogin first when start
    checkUserAlreadyLogin();
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FIREBASE PRACTICE",
          style: GoogleFonts.aboreto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
        
              const SizedBox(height: 10,),
        
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.white,
                child: Image.asset("images/clef.jpeg"),
              ),
        
              const SizedBox(height: 10,),
        
              Text(
                "SHOW OFF YOURSELF",
                style: GoogleFonts.akronim(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
        
              Container(
                child: Text(
                  "to share your fun!!!",
                  style: GoogleFonts.akronim(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
        
              const SizedBox(height: 10,),
        
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    TextfieldWidget(
                        textEditingController: emailTextEditingController,
                        iconData: Icons.email,
                        labelString: "email",
                        isObscure: false,
                    ),
        
                    const SizedBox(height: 10,),
        
                    TextfieldWidget(
                        textEditingController: passwordTextEditingController,
                        iconData: Icons.key,
                        labelString: "password",
                        isObscure: true,
                    ),
        
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
        
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: ElevatedButton(
                  onPressed: ()async{
                    //Login
                    try {
                      //user log in
                      final credential = await firebaseAuth.signInWithEmailAndPassword(
                          email: emailTextEditingController.text.toString().trim(),
                          password: passwordTextEditingController.text.toString().trim(),
                      );

                      //log in success and go to HomeScreen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);

                      //to check if log in success
                      firebaseAuth.authStateChanges()
                          .listen((User? user) {
                        if (user != null) {
                          print(user.uid);
                        }}
                      );


                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No account yet?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                        onPressed:(){
                          //change to Register page
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen(),),);
                        } ,
                        child: const Text(
                          "Sign up right away",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                    ),
        
                  ],
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
