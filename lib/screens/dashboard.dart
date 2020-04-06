import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_demo/services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in.dart';

class DashBoard extends StatefulWidget {
	@override
	_DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
	
//	final AuthService _authService = AuthService();
	final formKey = new GlobalKey<FormState>();
	String phoneNo, verId;
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				children: <Widget>[
					Padding(
						padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
						child: RaisedButton(
							child: Center(
								child: Text("Sign Out"),
							),
							onPressed: (){
								Authenticate().signout();
							},
						),
					),
					Padding(
						padding: EdgeInsets.only(left: 25.0, right: 25.0),
						child: RaisedButton(
							child: Center(
								child: Text("Verify"),
							),
							onPressed: (){
								return showModalBottomSheet(
									context: context,
									builder: (BuildContext bc){
										return Form(
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
													Padding(
														padding: EdgeInsets.only(left: 25.0, right: 25.0),
														child: RaisedButton(
															child: Center(
																child: Text("Login"),
															),
															onPressed: (){
																verifyNum(phoneNo);
															},
														),
													)
												],
											),
										);
									}
								);
//                Authenticate().handleAuth();
							},
						),
					),
				],
			),
		);
	}
	
	Future<void> verifyNum(num) async{
		final PhoneVerificationCompleted verified = (AuthCredential authRes){
			Authenticate().signIn(authRes);
		};
		final PhoneVerificationFailed failed = (AuthException authExcep){
		
		};
		final PhoneCodeSent smsSent = (String verId, [int forceResend]){
			this.verId = verId;
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
}