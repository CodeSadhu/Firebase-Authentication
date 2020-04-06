import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_demo/services/authenticate.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//  final AuthService _authService = AuthService();
  final formKey = new GlobalKey<FormState>();
  String phoneNo, verId, smsCode;
  bool codeSent = false;
  
  Future<void> verifyNum(num) async{
    final PhoneVerificationCompleted verified = (AuthCredential authRes){
      Authenticate().signIn(authRes);
    };
    final PhoneVerificationFailed failed = (AuthException authExcep){
    
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]){
      this.verId = verId;
      setState(() {
        this.codeSent = true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId){
      this.verId = verId;
    };
    
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: num,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: failed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeOut
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: "Enter Phone Number"),
                onChanged: (val) {
                  setState(() {
                    this.phoneNo = val;
                  });
                },
              ),
            ),
            codeSent ? Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: "Enter OTP"),
                onChanged: (val) {
                  setState(() {
                    this.smsCode = val;
                  });
                },
              ),
            ) : Container(),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: RaisedButton(
                child: Center(
                  child: codeSent ? Text("Login") : Text("Verify"),
                ),
                onPressed: (){
                  codeSent? Authenticate().signInViaOTP(smsCode, verId) : verifyNum(phoneNo);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}