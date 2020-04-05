import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_demo/screens/sign_in.dart';
import 'package:auth_demo/screens/dashboard.dart';

class Authenticate{
  //to handle auth
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData){
          return DashBoard();
        }
        else{
          return SignIn();
        }
      },
    );
  }
  //for signin
  signIn(AuthCredential authCreds){
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }
  //for signout
  signout(){
    FirebaseAuth.instance.signOut();
  }
}