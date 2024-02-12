import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:upmatev2/controllers/login_controller.dart';

import '../controllers/signup_controller.dart';
import '../models/user_model.dart';
import '../routes/route_name.dart';
import '../widgets/global/snack_bar.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await Get.offAllNamed(RouteName.start);
      } else {
        SnackBarWidget.showSnackBar(
            false, "your_email_or_password_is_wrong".tr);
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(false, "your_email_or_password_is_wrong".tr);
      if (kDebugMode) {
        print('Error signing in: $e');
      }
      //TODO: SHOW ERROR HERE
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

      if (userCredential.user != null) {
        return userCredential.user;
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      //TODO: SHOW ERROR HERE
      return null;
    }
  }

  Future<void> signInWithFacebook() async {
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
            await Get.offAllNamed(RouteName.start);
          } else {
            //TODO: SHOW ERROR HERE
          }
          return;

        case LoginStatus.cancelled:
          if (kDebugMode) {
            print('Facebook login cancelled by user');
          }
          //TODO: SHOW ERROR HERE
          return;

        case LoginStatus.failed:
          //TODO: SHOW ERROR HERE
          if (kDebugMode) {
            print('Error signing in with Facebook: ${result.message}');
          }
          return;

        case LoginStatus.operationInProgress:
          return;
      }
    } catch (e) {
      //TODO: SHOW ERROR HERE
      if (kDebugMode) {
        print('Error signing in with Facebook: $e');
      }
      return;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> sendOTP(String email) async {
    final url = Uri.parse('https://armoratech.my.id/upmateotp/otp');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, String> body = {'email': email};
    print("BODY: $body");
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      //success
      return;
    } else {
      //error
      print("error 500");
      throw Error();
    }
  }

  Future<bool> checkOTP(String inputOTP, bool isLogin) async {
    final dynamic controller =
        isLogin ? Get.find<LoginController>() : Get.find<SignupController>();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("otps")
        .doc(isLogin ? controller.userCredential.email! : controller.email.text)
        .get();
    final data = snapshot.get('otp');
    debugPrint("OTP: $data");

    return inputOTP == data;
  }

  Future<bool> isNewUser(String email) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: email)
          .get();
      return snapshot.docs.isEmpty;
    } catch (e) {
      debugPrint("ERRRORRR : $e");
      return false;
    }
  }

  Future<void> addUser(UserModel userModel) async {
    try {
      // doc.data() will be undefined in this case
      debugPrint("No such document!");
      await userModel.ref.set(userModel.toFirestore()).then(
            (value) => {
              if (kDebugMode) {debugPrint('User Added')}
            },
          );
    } catch (e) {
      debugPrint("ERROR : $e");
    }
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

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<UserModel?> getUserModel() async {
    QuerySnapshot<UserModel> querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel userModel, _) => userModel.toFirestore())
        .get();
    return querySnapshot.docs[0].data();
  }

  DocumentReference<Map<String, dynamic>> getCurrentUserReference() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userUid = user.uid;
      DocumentReference<Map<String, dynamic>> userReference =
          FirebaseFirestore.instance.collection('users').doc(userUid);
      return userReference;
    } else {
      // Handle the case where the user is not signed in
      throw Exception("User is not signed in.");
    }
  }
}
