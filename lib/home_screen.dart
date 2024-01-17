import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secondfirebasetest/login_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      body: Center(
        child: Column(
          children: [
            Text(
              "This is Home Screen!!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),

            SizedBox(height: 20,),

            //log out button
            ElevatedButton(
                onPressed:(){
                  firebaseAuth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()),);
                },
                child: Text(
                  "Log out",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
