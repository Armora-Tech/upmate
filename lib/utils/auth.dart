
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../routes/route_name.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in: $e');
      }
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
          final UserCredential userCredential = await _auth.signInWithCredential(credential);
          return userCredential.user;
  
        case LoginStatus.cancelled:
          if (kDebugMode) {
            print('Facebook login cancelled by user');
          }
          return null;

        case LoginStatus.failed:
          if (kDebugMode) {
            print('Error signing in with Facebook: ${result.message}');
          }
          return null;

        case LoginStatus.operationInProgress:
          return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Facebook: $e');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await Get.toNamed(RouteName.login);
  }
}
