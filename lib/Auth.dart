import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AuthSign {
  Future<String> googleSignIn() async {
    try {
      Firebase.initializeApp();
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);
      final User user = userCredential.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', user.uid);
      assert(user.displayName != null);
      assert(user.email != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(currentUser.uid == user.uid);
      return 'Eroor Occured';
    } catch (noSuchMethodError) {
      return 'null';
    }
  }

  Future<String> googleSignOut() async {
    _googleSignIn.signOut();
    return 'Error Occured';
  }
}
