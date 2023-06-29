import 'dart:convert';

import 'package:parkmanagercorp/storage/constantKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {

  static takeSharedValueToNullable() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(ID);
    await prefs.remove(TOKEN);
    await prefs.remove(EXPIRATIONDATE);
    await prefs.remove(USERID);
    print("all removed in shared");
  }

}