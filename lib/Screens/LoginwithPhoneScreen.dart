import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewholeproject/Functions/FlutterToast.dart';
import 'package:firebasewholeproject/Widgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool otpVisibility=false;
  FirebaseAuth auth=FirebaseAuth.instance;
  String auth_ID="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In With Phone"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFOrmField(
              controller: phoneController,
              hint: 'Enter Phone Number with +92 ',
              label: 'Phone Number',
              validator: (value) {},
              obsecureText: false,
              ontap: () {}),
              Visibility(
                visible: otpVisibility,
                child: CustomTextFOrmField(
                controller: otpController,
                hint: 'Enter 6 digit Code',
                label: 'OTP',
                validator: (value) {},
                obsecureText: false,
                ontap: () {}),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
if(otpVisibility==false){
auth.verifyPhoneNumber(
  phoneNumber: phoneController.text,
  timeout: Duration(minutes: 1),
  verificationCompleted: (context){}, 
verificationFailed: (e){
  FlutterToasts().errorFlutterToast(e.toString());
}, 
codeSent: (String authID,int? token){
auth_ID=authID;
FlutterToasts().successFlutterToast("OTP has been sent ${phoneController.text}}");
otpVisibility=true;
setState(() {
  
});
}, 
codeAutoRetrievalTimeout: (e){
  FlutterToasts().errorFlutterToast("Request Timed Out");
  otpVisibility=false;
  setState(() {
    
  });
});
}
else{
  final cred= PhoneAuthProvider.credential(verificationId: auth_ID, smsCode: otpController.text);


  auth.signInWithCredential(cred).then((value) {
    FlutterToasts().successFlutterToast("Successfully Looged In ");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
  });
}

        
      },label: Text(otpVisibility?"Verify OTP":"Send OTP"),),
    );
  }
}
