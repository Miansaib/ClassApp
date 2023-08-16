import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewholeproject/Screens/HomeScreen.dart';
import 'package:firebasewholeproject/Screens/LoginwithPhoneScreen.dart';
import 'package:firebasewholeproject/Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';

import '../Functions/FlutterToast.dart';
import '../Widgets/CustomTextFormField.dart';
import 'ForgotPassword.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final validatorKey = GlobalKey<FormState>();
  bool loading = false;
  // FormFieldValidator valid=(value) {
  //   if(value.isEmpty){
  //     return "Please Enter the Field";
  //   }
  // };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
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
              },
              obsecureText: false,
              ontap: () {},
            ),
            CustomTextFOrmField(
              controller: passwordController,
              hint: "Enter Password",
              label: "Password",
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter Password";
                } else
                  return null;
              },
              obsecureText: false,
              ontap: () {},
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: Text('Forgot Password!')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                if (validatorKey.currentState!.validate()) {
                  auth
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    FlutterToasts()
                        .successFlutterToast("Successfully Signed In");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    FlutterToasts().errorFlutterToast(error.toString());
                  });
                }
                setState(() {
                  loading = false;
                });
              },
              child: loading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : Text("Sign In"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't Have Account! "),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: Text("Sign Up")),
              ],
            ),
            FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => LoginWithPhoneScreen()));
                },
                label: Text("Sign up with Phone"))
          ],
        ),
      ),
    );
  }
}
