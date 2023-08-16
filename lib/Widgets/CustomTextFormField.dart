import 'package:flutter/material.dart';

class CustomTextFOrmField extends StatelessWidget {
  bool obsecureText=false;
  TextEditingController controller;
  String hint, label;
  FormFieldValidator validator;
  VoidCallback ontap;

  CustomTextFOrmField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.label,
      required this.validator,required this.obsecureText,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obsecureText,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap:ontap,
            child: Icon(Icons.remove_red_eye)),
          hintText: hint,
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.red
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.red
            )
          )
        ),
      ),
    );
  }
}
