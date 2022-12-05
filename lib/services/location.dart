import 'package:flutter/material.dart';

import 'package:location/location.dart';

class MyLocation extends ChangeNotifier {
  LocationData? loc;

  Future initLocationService() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return Text('not true');
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return const Text('not equal grant');
      }
    } else {}

    loc = await location.getLocation();
  }
}
