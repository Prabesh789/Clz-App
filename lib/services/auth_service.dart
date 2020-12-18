import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  // Create a signup function
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "User Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Signin Function
  Future<String> logIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "User Logged In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign out function
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  // Getter to return the state of the user.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();
}
