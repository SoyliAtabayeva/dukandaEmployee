import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model.dart';

class Services extends ChangeNotifier {
  User? user;
  set setUSer(User? us) => user = us;
  List<Product> searchedItems = [];

  var adress = '95.85.116.10:12443';

  Future<bool> login(String username, String password, String url) async {
    var ipAdress = Uri.http(adress, '/api/admin/employees/login');

    final http.Response response = await http.post(ipAdress,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'userName': username,
          'password': password,
          "program": "dukandaIshgar",
          'longitude': '80909090',
          'latitude': '787898988'
        }));

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      user = User(
          token: data['token'],
          userName: data['userName'],
          fullName: data['fullName'],
          qrClientCardShareAccess: data['qrClientCardShareAccess'],
          syncAccess: data['syncAccess'],
          productAnalyzeAccess: data['productAnalyzeAccess']);

      return true;
    } else {
      return false;
    }
  }

  //////////////////////////////////  Get  Item by Search   ////////////////////////////////////////////

  Future<bool> getItemsBySearch({search}) async {
    Uri uri = Uri.http(adress, 'api/v1/dukandaEmployee/items', {
      'search': '$search',
      'limit': '20',
      'offset': searchedItems.isNotEmpty ? searchedItems.length.toString() : '0'
    });
    final http.Response response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user?.token}'
    });

    if (response.statusCode == 200) {
      var searchedData = convert.jsonDecode(response.body);

      for (var i in searchedData) {
        List<Images> localImages = [];

        if (i['images'].isNotEmpty) {
          for (var images in i['images']) {
            localImages.add(Images(
                id: images['id'],
                normal: images['normal'],
                bigImg: images['bigImg'],
                mediumImg: images['mediumImg'],
                smallImg: images['smallImg'],
                mainImage: images['mainImage']));
          }
        }
        searchedItems.add(Product(
            status: i['status'],
            id: i['id'],
            code: i['code'],
            name: i['name'],
            nameTm: i['nameTm'],
            nameRu: i['nameRu'],
            mainUnit: i['mainUnit'],
            paretto: i['paretto'],
            eActive: i['eActive'],
            active: i['active'],
            isNew: i['isNew'],
            specode: i['specode'],
            images: localImages));
      }
      notifyListeners();
    }
    return true;
  }
}
