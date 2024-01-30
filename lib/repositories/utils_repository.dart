import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:upmatev2/models/utils_model.dart';

class UtilsRepository {
  Future<List<String>> getBadwords() async {
    QuerySnapshot querySnapshots = await FirebaseFirestore.instance
        .collection("utils")
        .withConverter(
            fromFirestore: UtilsModel.fromFirestore,
            toFirestore: (UtilsModel util, _) => util.toFirestore())
        .get();
    final utilData = querySnapshots.docs[0].data() as UtilsModel;
    return utilData.badWords;
  }

  Future<String> censorWords(String s) async {
    final filter = ProfanityFilter.filterAdditionally(await getBadwords());
    return filter.censor(s);
  }
}
