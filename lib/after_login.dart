import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AfterLogin extends StatelessWidget{
  const AfterLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text(
          "You have successfully logged In",
        ),
      ),
    );
  }
}