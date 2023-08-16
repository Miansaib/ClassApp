import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewholeproject/Functions/FlutterToast.dart';
import 'package:firebasewholeproject/Screens/SignInScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          Text("Are You Sure?"),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    auth.signOut().then((value) =>
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SignInScreen())));
                                  },
                                  child: Text("Logout")),
                              ElevatedButton(
                                style: ButtonStyle(
                                  
                                ),
                                  onPressed: () {
                                    dispose();
                                  },
                                  child: Text("Cancel")),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
