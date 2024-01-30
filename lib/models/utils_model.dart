import 'package:cloud_firestore/cloud_firestore.dart';

class UtilsModel {
  DocumentReference _ref;
  List<String> _badWords;
  List<String> _jobList;

  UtilsModel._(
      {required DocumentReference ref,
      required List<String> badWords,
      required List<String> jobList})
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
        jobList: data?['joblist'] ?? []
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "bad_words": _badWords,
      "joblist": _jobList,
    };
  }

  List<String> get badWords => _badWords;
}
