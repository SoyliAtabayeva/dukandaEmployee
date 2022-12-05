import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Data {
  String? data;
  Data({this.data});
}

class Location_Employee extends ChangeNotifier {
  String? adress;

  get getAdress {
    return adress ?? 'empty';
  }

  Future<bool> location(String uuid) async {
    var converted = json.decode(uuid);
    String name = converted['firmUUID'].toString();
    adress = converted["hostname"] + ':' + converted["port"];
    var ipAdress = Uri.http(getAdress, 'api/v1/control/location/employee');

    Map firmUUId = {
      'firmUUID': name,
    };

    final http.Response response = await http.post(ipAdress,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(firmUUId));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
