import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedBloc {
  save(var valueSaved) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(valueSaved));
  }
}
