import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_util.dart';

class UpMateFirebaseUser {
  UpMateFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

UpMateFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<UpMateFirebaseUser> upMateFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<UpMateFirebaseUser>(
      (user) {
        currentUser = UpMateFirebaseUser(user);
        updateUserJwtTimer(user);
        return currentUser!;
      },
    );
