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
  //for manual otp entry
  signInViaOTP(smsCode, verId){
  	AuthCredential authCredential = PhoneAuthProvider.getCredential(
		  verificationId: verId,
		  smsCode: smsCode
	  );
  	signIn(authCredential);
  }
  //for signout
  signout(){
    FirebaseAuth.instance.signOut();
  }
}