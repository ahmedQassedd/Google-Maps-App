import 'package:flutter/material.dart';
import 'package:google_maps/shared/consts/colors.dart';


Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  String? Function(String?)? validator,
  String? label,
  String? hint,
  required context ,
  IconData? suffixIcon,
  Function? suffixPressed,
  IconData? prefix,
  bool secure = false,
  InputDecoration? border,

}) =>
    TextFormField(
      cursorColor:  MyColors.primaryColor,
      scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20*4),
      controller: controller,
      keyboardType: inputType,
      validator: validator,
      obscureText: secure,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefix != null ? Icon(prefix , color: MyColors.primaryColor,) : null ,
        suffixIcon:  suffixIcon != null ? IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(suffixIcon)) : null ,
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6)
        ),
      ),
    );