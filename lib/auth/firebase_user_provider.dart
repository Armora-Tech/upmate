import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_util.dart';

class UpmateFirebaseUser {
  UpmateFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

UpmateFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<UpmateFirebaseUser> upmateFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<UpmateFirebaseUser>(
      (user) {
        currentUser = UpmateFirebaseUser(user);
        updateUserJwtTimer(user);
        return currentUser!;
      },
    );
