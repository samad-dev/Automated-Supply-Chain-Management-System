import 'package:asms/Constants/ColorConstants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginTextField extends StatelessWidget {
  var hide;
  var cont;
  String hint;
  LoginTextField({super.key, required this.hint, required this.cont, required this.hide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: hide,
        controller: cont,
        cursorColor: Color(ColorConstants.drkGreen1),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(ColorConstants.drkGreen1)),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(10)),
            hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: hint),
      ),
    );
  }
}
