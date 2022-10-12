import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_util.dart';

class ArmoraFirebaseUser {
  ArmoraFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

ArmoraFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ArmoraFirebaseUser> armoraFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ArmoraFirebaseUser>(
      (user) {
        currentUser = ArmoraFirebaseUser(user);
        updateUserJwtTimer(user);
        return currentUser!;
      },
    );
