import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'after_login.dart';
import 'firebase_options.dart';
import 'auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    title: 'Login Page Template with Firebase',
    home:
    StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot){
        if(snapshot.hasData){
          return const AfterLogin();
        }
        return const AuthScreen();
      },),
  ));
}