import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAPXbGerNDsMNE7SXeyT9e8OqBqQIYVas4",
            authDomain: "upmate-armora.firebaseapp.com",
            projectId: "upmate-armora",
            storageBucket: "upmate-armora.appspot.com",
            messagingSenderId: "159601934733",
            appId: "1:159601934733:web:b3c4b6058c88baac853dc4",
            measurementId: "G-YNDDMTHYX1"));
  } else {
    await Firebase.initializeApp();
  }
}
