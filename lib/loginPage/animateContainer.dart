import 'package:flutter/material.dart';

import 'checkingPage.dart';

Widget wifiCheker(context, AppSatus wifiChecker) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: SizedBox(
      width: 375,
      height: 68,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AnimatedContainer(
                  color: wifiChecker == AppSatus.wifiChecking
                      ? const Color.fromRGBO(255, 250, 223, 1)
                      : wifiChecker == AppSatus.wifiFailed
                          ? const Color.fromRGBO(255, 223, 223, 1)
                          : const Color.fromRGBO(223, 255, 236, 1),
                  width: wifiChecker == AppSatus.wifiChecking
                      ? 315
                      : wifiChecker == AppSatus.wifiFailed
                          ? 315
                          : 60,
                  height: 68,
                  duration: const Duration(seconds: 1),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.wifi,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              wifiChecker == AppSatus.wifiChecking
                                  ? 'wifi gözlenýär...'
                                  : wifiChecker == AppSatus.wifiFailed
                                      ? 'wifi tapylmady'
                                      : '',
                              style: const TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                wifiChecker == AppSatus.wifiFailed
                                    ? 'Baglanmak ucun salgylanmalara girin'
                                    : '',
                                style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  color: wifiChecker == AppSatus.locationChecking
                      ? const Color.fromRGBO(255, 250, 223, 1)
                      : wifiChecker == AppSatus.locationFailed
                          ? const Color.fromRGBO(255, 223, 223, 1)
                          : wifiChecker == AppSatus.locationSuccess
                              ? const Color.fromRGBO(223, 255, 236, 1)
                              : Colors.white,
                  width: wifiChecker == AppSatus.locationChecking
                      ? 315
                      : wifiChecker == AppSatus.locationFailed
                          ? 315
                          : wifiChecker == AppSatus.locationSuccess
                              ? 315
                              : 60,
                  height: 68,
                  duration: const Duration(seconds: 1),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                wifiChecker == AppSatus.locationChecking
                                    ? 'Dükan baglanýar'
                                    : wifiChecker == AppSatus.locationFailed
                                        ? 'Dukan tapylmady'
                                        : wifiChecker ==
                                                AppSatus.locationSuccess
                                            ? 'Ustunlukli baglandy'
                                            : '',
                                style: const TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              wifiChecker == AppSatus.locationFailed
                                  ? 'Shu yere basyp QR-kody okadyn'
                                  : '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                        wifiChecker == AppSatus.locationSuccess
                            ? const SizedBox(width: 75)
                            : const Text(''),
                        const Icon(
                          Icons.location_on,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
