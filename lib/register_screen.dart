import 'package:flutter/material.dart';
import 'package:secondfirebasetest/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController userNameTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firebase Practice",
        ),
      ),

      body: Column(
        children: [
          TextfieldWidget(
            textEditingController: userNameTextEditingController,
            labelString: "User name",
            isObscure: false,
          ),
        ],
      ),

    );
  }
}