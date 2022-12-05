import 'package:dukanda_ishgar/services/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'model.dart';

/* getting item  by Id*/

class ItemId extends ChangeNotifier {
  var adress = '95.85.116.10:12443';
  Product? objectId;
  Stocks? dataStocksId;
  Product? objectBarcode;
  Stocks? dataStocksBarcode;
  List<Product?> seenItem = [];

  Future<bool> getItemById(
      {required BuildContext context,
      required int id,
      required List user,
      clientId,
      cardNo}) async {
    Uri url = Uri.http(
      adress,
      'api/v2/dukandaEmployee/items/$id',
      {
        'language': 'tm',
        'clientId': user.isEmpty ? '0' : '$clientId',
        'cardNo': user.isEmpty ? '0' : '$cardNo',
        'program': 'dukandaEmployee',
        'itemId': '$id'
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
      var data = convert.jsonDecode(response.body);

      List<Real> realStocks = [];
      List<Real> unrealStocks = [];
      List<Images> idImages = [];
      for (var item in data['images']) {
        idImages.add(
          Images(
            id: item['id'],
            normal: item['normal'],
            bigImg: item['bigImg'],
            smallImg: item['smallImg'],
            mainImage: item['mainImage'],
            mediumImg: item['mediumImg'],
          ),
        );
      }

      for (var item in data['stocks']['real']) {
        realStocks.add(Real(
            name: item['name'],
            nr: item['nr'],
            onhand: item['onhand'],
            reserved: item['reserved'],
            permissionType: item['permissionType'],
            priority: item['priority'],
            createdAt: item['createdAt'],
            updatedAt: item['updatedAt']));
      }
      for (var item in data['stocks']['unreal']) {
        unrealStocks.add(
          Real(
              name: item['name'],
              nr: item['nr'],
              onhand: item['onhand'],
              reserved: item['reserved'],
              permissionType: item['permissionType'],
              priority: item['priority'],
              createdAt: item['createdAt'],
              updatedAt: item['updatedAt']),
        );
      }
      dataStocksId = Stocks(
          real: realStocks,
          unreal: unrealStocks,
          lastFullSyncTime: data['stocks']['lastFullSyncTime'],
          onlyChangedSyncTime: data['stocks']['onlyChangedSyncTime']);

      objectId = Product(
          price: data['price'],
          brand: data['brand'],
          mediumImg: data['mediumImg'],
          smallImg: data['smallImg'],
          countOfComplect: data['countOfComplect'],
          discount: data['discount'],
          unitCount: data['unitCount'],
          unit: data['unit'],
          brandImg: data['brandImg'],
          lastGroup: data['lastGroup'],
          mainGroup: data['mainGroup'],
          discountPrice: data['discountPrice'],
          discountType: data['discountType'],
          vidio: data['vidio'],
          bigImg: data['bigImg'],
          currency: data['currency'],
          status: data['status'],
          id: data['id'],
          code: data['code'],
          name: data['name'],
          mainUnit: data['mainUnit'],
          paretto: data['paretto'],
          specode: data['specode'],
          images: idImages,
          stocks: dataStocksId);
      if (objectId != null) {
        seenItem.add(objectId);
      }
      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

  /*Getting  item by reading the QRcode*/

  Future<bool> getObjectByBarcode(
      {required BuildContext context,
      required int barcode,
      required List user,
      clientId,
      cardNo}) async {
    Uri url = Uri.http(
      adress,
      'api/v2/dukandaEmployee/items/barcode/$barcode',
      {
        'language': 'tm',
        'clientId': user.isEmpty ? '0' : '$clientId',
        'cardNo': user.isEmpty ? '0' : '$cardNo',
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
      var data = convert.jsonDecode(response.body);

      List<Real> realStocks = [];
      List<Real> unrealStocks = [];
      List<Images> idImages = [];
      for (var item in data['images']) {
        idImages.add(
          Images(
            id: item['id'],
            normal: item['normal'],
            bigImg: item['bigImg'],
            smallImg: item['smallImg'],
            mainImage: item['mainImage'],
            mediumImg: item['mediumImg'],
          ),
        );
      }

      for (var item in data['stocks']['real']) {
        realStocks.add(Real(
            name: item['name'],
            nr: item['nr'],
            onhand: item['onhand'],
            reserved: item['reserved'],
            permissionType: item['permissionType'],
            priority: item['priority'],
            createdAt: item['createdAt'],
            updatedAt: item['updatedAt']));
      }
      for (var item in data['stocks']['unreal']) {
        unrealStocks.add(
          Real(
              name: item['name'],
              nr: item['nr'],
              onhand: item['onhand'],
              reserved: item['reserved'],
              permissionType: item['permissionType'],
              priority: item['priority'],
              createdAt: item['createdAt'],
              updatedAt: item['updatedAt']),
        );
      }
      dataStocksBarcode = Stocks(
          real: realStocks,
          unreal: unrealStocks,
          lastFullSyncTime: data['stocks']['lastFullSyncTime'],
          onlyChangedSyncTime: data['stocks']['onlyChangedSyncTime']);

      objectBarcode = Product(
          price: data['price'],
          brand: data['brand'],
          mediumImg: data['mediumImg'],
          smallImg: data['smallImg'],
          countOfComplect: data['countOfComplect'],
          discount: data['discount'],
          unitCount: data['unitCount'],
          unit: data['unit'],
          brandImg: data['brandImg'],
          lastGroup: data['lastGroup'],
          mainGroup: data['mainGroup'],
          discountPrice: data['discountPrice'],
          discountType: data['discountType'],
          vidio: data['vidio'],
          bigImg: data['bigImg'],
          currency: data['currency'],
          status: data['status'],
          id: data['id'],
          code: data['code'],
          name: data['name'],
          mainUnit: data['mainUnit'],
          paretto: data['paretto'],
          specode: data['specode'],
          images: idImages,
          stocks: dataStocksBarcode);
      notifyListeners();
      if (objectBarcode != null) {
        seenItem.add(objectId);
        notifyListeners();
        print('!!!!!!!!!!!!!!!!!!!');
        print(seenItem.length);
      }

      return true;
    } else {
      return false;
    }
  }
}
