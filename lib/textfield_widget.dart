import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {

  final TextEditingController textEditingController;
  final IconData iconData;
  final String labelString;
  final bool isObscure;

  TextfieldWidget({
    required this.textEditingController,
    required this.iconData,
    required this.labelString,
    required this.isObscure,

});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        labelText: labelString,
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),

      obscureText: isObscure,
    );
  }
}
