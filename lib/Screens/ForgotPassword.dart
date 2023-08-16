import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewholeproject/Functions/FlutterToast.dart';
import 'package:firebasewholeproject/Widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final validatorKey=GlobalKey<FormState>();
  FirebaseAuth auth=FirebaseAuth.instance;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
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
                  if(value.isEmpty){
                    return "Enter Email Address";
                  }
                  else
                  return null;
                },
                obsecureText: false,
                ontap: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        setState(() {
          loading=true;
        });
        if(validatorKey.currentState!.validate()){
          auth.sendPasswordResetEmail(email: emailController.text).then((value) {

            FlutterToasts().successFlutterToast("Email Sent Successfully");
            Navigator.pop(context);
            setState(() {
              loading=false;
            });
          }).onError((error, stackTrace) {
            FlutterToasts().errorFlutterToast(error.toString());
            setState(() {
              loading=false;
            });
          });
        }

      }, label: loading ?CircularProgressIndicator(color: Colors.white,):Text("Send Verification Email")),
    );
  }
}
