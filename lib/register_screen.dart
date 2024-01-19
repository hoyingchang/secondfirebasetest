import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondfirebasetest/home_screen.dart';
import 'package:secondfirebasetest/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String downloadImageUrl = "";

  final ImagePicker picker = ImagePicker();
  XFile? image;




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
              onTap: ()async{
                //user pick picture
                // Pick an image.
                image = await picker.pickImage(source: ImageSource.gallery);

                // Capture a photo.
                // photo = await picker.pickImage(source: ImageSource.camera);

                // refresh image
                setState(() {
                  image;
                });
              },

              //put image to avatar
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.2,
                backgroundImage: image == null
                  ? const AssetImage("images/avatar.jpeg") as ImageProvider
                  : FileImage(File(image!.path)),
                child: image == null
                  ? Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.white,
                  )
                  : null,
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
              margin: const EdgeInsets.only(left: 20,right: 20),
              child: ElevatedButton(
                onPressed: () async{

                  //Sign up to Firebase Authentication
                  try {
                    //to create a new account to Authentication
                    final credential = await firebaseAuth.createUserWithEmailAndPassword(
                      email: emailTextEditingController.text.toString().trim(),
                      password: passwordTextEditingController.text.toString().trim(),
                    );
                    print(credential.user?.uid);

                    //sign up and log in success and then go to HomeScreen
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()),);


                    //add a new user to firestore
                    CollectionReference user = firebaseFirestore.collection("users");
                    user.add({
                      "username":userNameTextEditingController.text.toString().trim(),
                      "email": emailTextEditingController.text.toString().trim(),
                    });

                    //upload image to firebase storage
                    //create image filename first, use time to be the file name to avoid conflict
                    String userImageFileName = DateTime.now().millisecondsSinceEpoch.toString();

                    //image file name reference
                    Reference storageRef = firebaseStorage
                        .ref()
                        .child("usersImages").child("$userImageFileName.jpg");

                    //connect filename and image
                    UploadTask uploadImageTask = storageRef.putFile(File(image!.path));

                    //get snapshot of position of image
                    TaskSnapshot imagePositionSnapshot = await uploadImageTask.whenComplete((){});

                    //to get the url via image position snapshot and give to global downloadImageUrl valuable
                    await imagePositionSnapshot
                        .ref
                        .getDownloadURL()
                        .then((imageUrl){
                      downloadImageUrl = imageUrl;
                    });

                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "The password provided is too weak.",
                          ),),
                      );
                    } else if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                              "The account already exists for that email.",
                            ),),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),),
                    );
                  }
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