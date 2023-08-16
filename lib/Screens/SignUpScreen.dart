import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewholeproject/Functions/FlutterToast.dart';
import 'package:flutter/material.dart';

import '../Widgets/CustomTextFormField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth =FirebaseAuth.instance;
  final validatorKey = GlobalKey<FormState>();
  bool obsText=true;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Form(
        key: validatorKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFOrmField(
                controller: emailController,
                hint: "Enter Email Address",
                label: "Email Address",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Email Address";
                  } else {
                    return null;
                  }
                }, obsecureText: false, ontap: () {  },),
            CustomTextFOrmField(
              obsecureText: obsText,
                controller: passwordController,
                hint: "Enter Password",
                label: "Password",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Password";
                  } else
                    return null;
                }, ontap: () { 
                  setState(() {
                    obsText=!obsText;
                  });
                 },),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading=true;
                });
                if (validatorKey.currentState!.validate()) {
                  auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) {
                    setState(() {
                      loading=false;
                    });
                    Navigator.pop(context);
                    FlutterToasts().successFlutterToast("Successfully Signed Up");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading=false;
                    });
                    FlutterToasts().errorFlutterToast(error.toString());
                  });
                }
              },
              child: loading ?CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ):Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
