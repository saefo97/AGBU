
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future <String?> signUp(String email,String password) async {
   try {
     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     userCredential.user!.sendEmailVerification();
     return null;
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

  String handleError(dynamic e){
    if(e is FirebaseAuthException){
      return e.code;
    }
    return "Error";
  }


  signOut() {
    _auth.signOut();
  }
}