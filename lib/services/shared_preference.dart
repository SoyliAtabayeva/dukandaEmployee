import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs extends ChangeNotifier {
  static String valueSharedPreferences = 'scanData';
  String? scannedData;

  String get getScannedData {
    return scannedData ?? 'empty';
  }

  Future readScanData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getString(valueSharedPreferences);
    var a = json.decode(data ?? 'empty');
    scannedData = a["hostname"] + ':' + a["port"];
    notifyListeners();

    return scannedData;
  }

  Future<bool> scanDataWriter({value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var a = await sharedPreferences.setString(valueSharedPreferences, value);
    return a;
  }

  Future<bool> deleteData({value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var a = await sharedPreferences.clear();
    return a;
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
