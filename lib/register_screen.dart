import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondfirebasetest/textfield_widget.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firebase Practice",
          style: GoogleFonts.aboreto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20,),

            Text(
              "Apply an account",
              style: GoogleFonts.akronim(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),

            Text(
              "to join us right away!!!",
              style: GoogleFonts.akronim(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20,),

            //user's avatar
            GestureDetector(
              onTap: (){
                //user pick picture
              },

              child: const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  "images/avatar.jpeg",
                ),
              ),

            ),

            const SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: TextfieldWidget(
                textEditingController: userNameTextEditingController,
                iconData: Icons.person,
                labelString: "username",
                isObscure: false,
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: TextfieldWidget(
                textEditingController: emailTextEditingController,
                iconData: Icons.email,
                labelString: "email",
                isObscure: false,
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: TextfieldWidget(
                textEditingController: passwordTextEditingController,
                iconData: Icons.key,
                labelString: "password",
                isObscure: true,
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20,right: 20),
              child: ElevatedButton(
                onPressed: (){

                  //Sign up to Firebase Authentication

                },
                child: const Text(
                    "Sign Up",
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed:(){
                        //go to Log in page
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>const LoginScreen(),),
                        );
                      },
                      child:const Text(
                          "Go Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}