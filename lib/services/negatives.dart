import 'package:dukanda_ishgar/services/model.dart';
import 'package:dukanda_ishgar/services/requests.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class Negatives extends ChangeNotifier {
  List<Product> negativeItems = [];
  List<Images> localImages = [];
  var adress = '95.85.116.10:12443';
  Future<bool> negative(BuildContext context) async {
    var url = Uri.http(adress, 'api/v2/dukandaEmployee/negatives', {
      'limit': '20',
      'offset':
          negativeItems.isNotEmpty ? negativeItems.length.toString() : '0',
      'warehouseNr': '200',
      'program': 'dukandaEmployee',
    });

    final http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${context.read<Services>().user?.token}'
    });

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      for (var i in data) {
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
        negativeItems.add(Product(
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
      

      return true;
    } else {
      return false;
    }
  }
}
