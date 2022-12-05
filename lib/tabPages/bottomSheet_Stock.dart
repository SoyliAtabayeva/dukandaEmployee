import 'package:dukanda_ishgar/services/itemBarcodeRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../services/model.dart';

Widget bottomSheetStock(bool check) {
  return Consumer<ItemId>(
    builder: (context, value, child) {
      Stocks? stockInfo =
          check == true ? value.objectId?.stocks : value.objectBarcode?.stocks;
      var now = DateTime.now();
      var mins =
          Duration(seconds: stockInfo?.onlyChangedSyncTime ?? 0).inMinutes;
      var hour = Duration(seconds: stockInfo?.lastFullSyncTime ?? 0).inHours;

      var onlySync = now.subtract(Duration(minutes: mins));
      var fullSync = now.subtract(Duration(hours: hour));
      var onlyFormat = DateFormat('yyyy-MM-dd – kk:mm').format(onlySync);
      var fullFormat = DateFormat('yyyy-MM-dd – kk:mm').format(fullSync);

      return ListView(
        children: [
          tileName('Hakyky Stock', stockInfo?.real),
          tileName('Yoldaky Stock', stockInfo?.unreal),
          ExpansionTile(
            textColor: Colors.black87,
            title: Row(
              children: [
                SvgPicture.asset('assets/Exchange.svg'),
                const SizedBox(width: 15),
                const Text(
                  'Stok sinhronlanma wagty',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            children: [
              ListTile(
                title: const Text('Çalt sinhronlanma',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                subtitle: Text(onlyFormat),
                trailing: Text('$mins min'),
              ),
              ListTile(
                title: const Text('Doly sinhronlanma',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                subtitle: Text(fullFormat),
                trailing: Text('$hour sag'),
              )
            ],
          ),
        ],
      );
    },
  );
}

tileName(
  String text,
  List<Real>? real,
) {
  List<Real> realItem = [];

  var filter = real
      ?.where((element) => element.permissionType == 'amount')
      .toList()
      .map((e) => e.onhand)
      .fold(
          0,
          (previousValue, element) =>
              element + int.parse(previousValue.toString()));

  return ExpansionTile(
    initiallyExpanded: true,
    textColor: Colors.black87,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/shopping-bag.svg'),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        filter != 0 ? Text('$filter +Bar') : const Text('')
      ],
    ),
    children: List.generate(
      real?.length ?? 0,
      (index) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(real?[index].name ?? 'null'),
            real?[index].permissionType == 'amount'
                ? Text('${real?[index].onhand}')
                : real?[index].permissionType == 'available' &&
                        real?[index].onhand != 0
                    ? const Text('Bar', style: TextStyle(color: Colors.green))
                    : const Text(
                        'Yok',
                        style: TextStyle(color: Colors.red),
                      )
          ],
        ),
      ),
    ),
  );
}
