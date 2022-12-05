import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dukanda_ishgar/languages.dart';
import 'package:dukanda_ishgar/loginPage/loginPage.dart';
import 'package:dukanda_ishgar/loginPage/wifiChecker.dart';
import 'package:dukanda_ishgar/services/shared_preference.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'animateContainer.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({Key? key}) : super(key: key);

  @override
  State<CheckingPage> createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late final PageController _pageController;

  AppSatus wifiChecker = AppSatus.wifiChecking;
  Future? scanDataExist;
  int selectedPage = 0;

  @override
  void initState() {
    int selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return ('$e  ERROR');
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus == ConnectivityResult.wifi) {
      setState(() {
        wifiChecker = AppSatus.locationChecking;
      });
      scanDataExist = context.read<Prefs>().readScanData();

      if (scanDataExist == null) {
        wifiChecker = AppSatus.locationFailed;
      } else {
        setState(
          () {
            wifiChecker = AppSatus.locationSuccess;
            if (selectedPage == 0) {
              _pageController.nextPage(
                  duration: const Duration(seconds: 4), curve: Curves.ease);
            }
          },
        );
      }
    } else {
      setState(
        () {
          wifiChecker = AppSatus.wifiFailed;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: const [PopMenuButton()],
      ),
      bottomNavigationBar: wifiCheker(context, wifiChecker),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (page) {
          setState(
            () {
              selectedPage = page;
            },
          );
        },
        children: <Widget>[const WifiCheckerPage(), LoginPage()],
      ),
    );
  }
}

enum AppSatus {
  wifiChecking,
  wifiFailed,
  locationChecking,
  locationFailed,
  wifiSuccess,
  locationSuccess
}
