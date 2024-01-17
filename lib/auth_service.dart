import 'package:firebase_auth/firebase_auth.dart';


class AuthService{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Register user
  Future<User?> register(String email, String password) async{

    //Check current auth state
    // FirebaseAuth.instance.authStateChanges().listen(
    //         (User? user){
    //       if(user == null){
    //         print("User is currently signed out!");
    //       } else{
    //         print("User is signed in!");
    //       }
    //         }
    //         );


    //create user account to Firebase
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,
    );

    return userCredential.user;
  }



}

