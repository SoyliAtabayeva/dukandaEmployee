import 'package:dukanda_ishgar/homePage/homePage.dart';
import 'package:dukanda_ishgar/homePage/negativeItems.dart';

import 'package:dukanda_ishgar/loginPage/checkingPage.dart';
import 'package:dukanda_ishgar/loginPage/loginPage.dart';
import 'package:dukanda_ishgar/loginPage/wifiChecker.dart';
import 'package:dukanda_ishgar/qrReader.dart';

import 'package:dukanda_ishgar/services/itemBarcodeRequest.dart';
import 'package:dukanda_ishgar/services/clientCardReader.dart';
import 'package:dukanda_ishgar/services/clientsCard.dart';
import 'package:dukanda_ishgar/services/location.dart';
import 'package:dukanda_ishgar/services/location_employee.dart';
import 'package:dukanda_ishgar/services/negatives.dart';
import 'package:dukanda_ishgar/services/requests.dart';
import 'package:dukanda_ishgar/services/shared_preference.dart';
import 'package:dukanda_ishgar/tabPages/barcodeQr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Services>(create: (_) => Services()),
      ChangeNotifierProvider<MyLocation>(create: (_) => MyLocation()),
      ChangeNotifierProvider<Location_Employee>(
          create: (_) => Location_Employee()),
      ChangeNotifierProvider<Prefs>(create: (_) => Prefs()),
      ChangeNotifierProvider<ItemId>(create: (_) => ItemId()),
      ChangeNotifierProvider<ClientCard>(create: (_) => ClientCard()),
      ChangeNotifierProvider<Negatives>(create: (_) => Negatives()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukanda Ishgar',
      debugShowCheckedModeBanner: false,
      // home: InitialPage(),
      initialRoute: MyRoutes.checking,
      onGenerateRoute: (setting) {
        switch (setting.name) {
          // case MyRoutes.initialPage:
          //   return MaterialPageRoute(builder: (context) => InitialPage());
          case MyRoutes.wifiCheckerPage:
            return MaterialPageRoute(
                builder: (context) => const WifiCheckerPage());
          case MyRoutes.loginPage:
            return MaterialPageRoute(builder: (context) => LoginPage());
          case MyRoutes.homePage:
            return MaterialPageRoute(builder: (context) => HomePage());
          case MyRoutes.qrReader:
            return MaterialPageRoute(
                builder: (context) => const QRViewExample());
          case MyRoutes.checking:
            return MaterialPageRoute(
                builder: (context) => const CheckingPage());
          case MyRoutes.barCodeReader:
            return MaterialPageRoute(
                builder: (context) => const BarcodeQrRaeder());
          case MyRoutes.clientCardReader:
            return MaterialPageRoute(
                builder: (context) => const ClienCardReader());
          case MyRoutes.negativeItems:
            return MaterialPageRoute(
                builder: (context) => const NegativeItems());

          default:
        }
      },
    );
  }
}

class MyRoutes {
  // static const String initialPage = '/';
  static const String checking = '/';
  static const String wifiCheckerPage = '/wifiCheckerPage';
  static const String loginPage = '/loginPage';
  static const String homePage = '/homePage';
  static const String qrReader = '/qrReader';
  static const String barCodeReader = '/BarCodeReader';
  static const String clientCardReader = '/clientCardReader';
  static const String negativeItems = '/negativeItems';
}
