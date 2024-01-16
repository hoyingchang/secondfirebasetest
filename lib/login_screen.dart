import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondfirebasetest/register_screen.dart';
import 'package:secondfirebasetest/textfield_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

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
        
              SizedBox(height: 10,),
        
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.white,
                child: Image.asset("images/clef.jpeg"),
              ),
        
              SizedBox(height: 10,),
        
              Container(
                child: Text(
                  "SHOW OFF YOURSELF",
                  style: GoogleFonts.akronim(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
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
        
              SizedBox(height: 10,),
        
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
        
                    SizedBox(height: 10,),
        
                    TextfieldWidget(
                        textEditingController: passwordTextEditingController,
                        iconData: Icons.key,
                        labelString: "password",
                        isObscure: true,
                    ),
        
                    SizedBox(height: 10,),
                  ],
                ),
              ),
        
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20,right: 20),
                child: ElevatedButton(
                  onPressed: (){
                    //Login
                  },
                  child: Text(
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
                margin: EdgeInsets.only(left: 20,right: 20),
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
                        child: Text(
                          "Singup right away",
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
