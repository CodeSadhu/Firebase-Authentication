import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_demo/models/user.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;	//Firebase Auth instance

  //create user obj from firebase
  User _userFromFbase(FirebaseUser user) {
    return user != null ? new User(uid: user.uid) : null;
  }

	// Anonymous Sign-In
	Future signInAnon() async {
		try{
			AuthResult resAuth = await _auth.signInAnonymously();
			FirebaseUser user = resAuth.user;
			return _userFromFbase(user);

		}	catch(e) {
			print(e.toString());
			return null;
		}
	}

	// Email Sign-In

	// Email Register

	//Sign Out
}