import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../routes/route_name.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await Get.toNamed(RouteName.start);
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in: $e');
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) return;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await Get.toNamed(RouteName.start);
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }

      return;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      return;
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          if (userCredential.user != null) {
            await Get.toNamed(RouteName.start);
          } else {
            Fluttertoast.showToast(
                msg: "Login Failed!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
          return;

        case LoginStatus.cancelled:
          if (kDebugMode) {
            print('Facebook login cancelled by user');
          }
          return;

        case LoginStatus.failed:
          Fluttertoast.showToast(
              msg: "Login Failed!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          if (kDebugMode) {
            print('Error signing in with Facebook: ${result.message}');
          }
          return;

        case LoginStatus.operationInProgress:
          return;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Facebook: $e');
      }
      return;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await Get.toNamed(RouteName.login);
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up with email/password: $e');
      }
      return null;
    }
  }

  Future<User?> signUpWithGoogle() async {
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
        print('Error signing up with Google: $e');
      }
      return null;
    }
  }

  Future<User?> signUpWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          return userCredential.user;

        case LoginStatus.cancelled:
          if (kDebugMode) {
            print('Facebook sign-up cancelled by user');
          }
          return null;

        case LoginStatus.failed:
          if (kDebugMode) {
            print('Error signing up with Facebook: ${result.message}');
          }
          return null;

        case LoginStatus.operationInProgress:
          return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up with Facebook: $e');
      }
      return null;
    }
  }

  DocumentReference getCurrentUserReference()  {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userUid = user.uid;
      DocumentReference userReference = FirebaseFirestore.instance.collection('users').doc(userUid);
      return userReference;
    } else {
      // Handle the case where the user is not signed in
      throw Exception("User is not signed in.");
    }
  }
}
