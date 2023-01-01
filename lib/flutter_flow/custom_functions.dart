

bool compare(
  String one,
  String two,
) {
  // Add your function code here!
  if (int.parse(one) == int.parse(two)) {
    return true;
  } else {
    return false;
  }
}

String? joinLString(
  List<String> str,
  String separator,
) {
  // Add your function code here!
  String finalstr = str.join(separator);
  return finalstr;
}

List<String> normInterests(List<String> lists) {
  // Add your function code here!
  for (int i = 0; i < lists.length; i++) {
    List<String> ts = lists[i].split(" ");
    ts.removeWhere((str) {
      return str == "#";
    });
    lists[i] = ts.join(" ");
  }
  return lists;
}

List<String> hashtagInterest(List<String> interests) {
  // Add your function code here!
  for (int i = 0; i < interests.length; i++) {
    interests[i] = '# ${interests[i]}';
  }
  return interests;
}

String sintenrest(String str) {
  // Add your function code here!
  return str.replaceAll('#', '').trim();
}

int subtraction(
  int n1,
  int n2,
) {
  // Add your function code here!
  return n1 - n2;
}

int getIndex(
  List<String> lst,
  String item,
) {
  // Add your function code here!
  return lst.indexWhere((element) => element == item);
}

bool cregex(
  String str,
  String? regex,
) {
  // Add your function code here!
  RegExp pattern = RegExp(r'$regex');
  return pattern.hasMatch(str);
}

int scount(String str) {
  // Add your function code here!
  return str.length;
}

DocumentReference? newCustomFunction(String? pathString) {
  String strref = pathString!.substring(pathString.lastIndexOf("/"));
  return FirebaseFirestore.instance.collection('users').doc(strref);
}
