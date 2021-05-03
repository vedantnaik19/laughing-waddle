import 'package:contacts_service/contacts_service.dart';

class Helper {
  static String getInitials(String string, [int limitTo = 2]) {
    if (string == null || string.isEmpty) {
      return '';
    }

    var buffer = StringBuffer();
    var split = string.split(' ');

    //For one word
    if (split.length == 1) {
      return string.substring(0, 1);
    }

    for (var i = 0; i < (limitTo ?? split.length); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  static String getPhones(Iterable<Item> phones) {
    var list = phones.toList();
    String numbers = "";
    list.forEach((e) {
      numbers = e.value.toString() + " ";
    });
    return numbers;
  }
}
