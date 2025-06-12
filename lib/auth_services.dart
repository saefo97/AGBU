
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future <String?> signUp(String email,String password) async {
   try {
     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     userCredential.user!.sendEmailVerification();

     signOut();
     return "Please Check Your Email";
   } catch (e) {
     print(e);
     return handleError(e);
   }
  }

  Future <String?> signIn(String email,String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(!userCredential.user!.emailVerified){
        userCredential.user!.sendEmailVerification();
        signOut();
        return "Please Check Your Email";
      }
      return null;
    } catch (e) {
      print(e);
      return handleError(e);
    }
  }

  String handleError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'user-not-found':
          return 'No user found with this email.';
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'account-exists-with-different-credential':
          return 'An account already exists with the same email address but different sign-in credentials.';
        case 'invalid-credential':
          return 'The credential is invalid or has expired.';
        case 'invalid-verification-code':
          return 'The verification code is invalid.';
        case 'invalid-verification-id':
          return 'The verification ID is invalid.';
        case 'user-mismatch':
          return 'The credential does not match the current user.';
        case 'expired-action-code':
          return 'The verification link has expired.';
        default:
          return 'Authentication error: ${e.message ?? e.code}';
      }
    }
    return 'An unexpected error occurred. Please try again.';
  }



  Future<void> signOut() async {
    await _auth.signOut().then((value) async {

      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userName');
      print("***************************************************************");
      print("cache cleared");
      print("***************************************************************");
    },);
  }
}