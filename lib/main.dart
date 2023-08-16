import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasewholeproject/Screens/HomeScreen.dart';
import 'package:firebasewholeproject/Screens/SignInScreen.dart';
import 'package:flutter/material.dart';
void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
FirebaseAuth auth=FirebaseAuth.instance;
runApp(MaterialApp(
  darkTheme: ThemeData.dark(),
  home: auth.currentUser ==  null ? const SignInScreen():const HomeScreen(),
  debugShowCheckedModeBanner: false,
));


}