import 'dart:convert';

import 'package:dukanda_ishgar/services/requests.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ClientCard extends ChangeNotifier {
  var adress = '95.85.116.10:12443';
  List<CardUser> previousUser = [];
  CardUser? user;
  List users = [];
  int once = 0;
  Future<bool> getClientInfo(BuildContext context, card) async {
    Uri url = Uri.http(
      adress,
      'api/v1/dukandaEmployee/clients/$card',
      {
        'program': 'dukandaEmployee',
      },
    );

    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${context.read<Services>().user?.token}'
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      user = CardUser(
          id: data['id'],
          code: data['code'],
          name: data['name'],
          cardNo: data['cardNo'],
          phoneNumber: data['phoneNumber']);

      users.add(user);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  cleanTheUsersList() {
    users.clear();
    notifyListeners();
  }

  cleanThePreviousUserList(value) {
    previousUser.remove(value);
    notifyListeners();
  }

  addToTheList(value) {
    once += 1;
    if (!users.contains(value)) {
      previousUser.add(value);
      notifyListeners();
    }
  }

  addToUsers(value) {
    once += 1;
    if (users.isEmpty) {
      users.add(value);
      notifyListeners();
    }
  }
}

class CardUser {
  int id;
  String code;
  String name;
  String cardNo;
  String phoneNumber;
  CardUser(
      {required this.id,
      required this.code,
      required this.name,
      required this.cardNo,
      required this.phoneNumber});
}
