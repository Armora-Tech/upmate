import 'package:cloud_firestore/cloud_firestore.dart';

class UtilsModel {
  DocumentReference _ref;
  List<dynamic> _badWords;
  List<dynamic> _jobList;

  UtilsModel._(
      {required DocumentReference ref,
      required List<dynamic> badWords,
      required List<dynamic> jobList})
      : _ref = ref,
        _badWords = badWords,
        _jobList = jobList;

  factory UtilsModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return UtilsModel._(
        ref: snapshot.reference,
        badWords: data?['bad_words'] ?? [],
        jobList: data?['joblist'] ?? []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "bad_words": _badWords,
      "joblist": _jobList,
    };
  }

  List<String> get badWords =>
      _badWords.map((e) => e.toString().toLowerCase()).toList();
}
