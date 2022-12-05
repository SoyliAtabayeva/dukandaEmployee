// ignore_for_file: must_be_immutable

import 'package:dukanda_ishgar/languages.dart';
import 'package:flutter/material.dart';

import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key? key}) : super(key: key);
  List<Widget> icons = [
    Image.asset(
      'assets/DukandaIshgar.png',
      width: 263,
      height: 95,
    ),
    Image.asset(
      'assets/Frame 8503 (Traced).png',
      width: 263,
      height: 95,
    ),
    Image.asset(
      'assets/Frame 8505.png',
      width: 263,
      height: 95,
    ),
    Image.asset(
      'assets/credit-card 1 (Traced).png',
      width: 263,
      height: 95,
    ),
  ];
  List<String> title = [
    "How to use this App?",
    "Connect to the Store’s wifi",
    "Read the Store’s QR -code",
    "Read the Store’s QR -code",
  ];
  List<String> texts = [
    "In this app you  can learn the products ‘ informations and costs by using QR code",
    "It checks your wifi connection ,so you need to connect your device our local wifi.After that it allaws you to use this app!",
    "Finally read the Store’s Qr-code ,then you can read all the products QR-code and know the informations and costs of them.Discount Card - you can ask from workers about discount card.After getting that you can get discounted products!",
    "Finally read the Store’s Qr-code ,then you can read all the products QR-code and know the informations and costs of them.Discount Card - you can ask from workers about discount card.After getting that you can get discounted products!",
  ];

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late int selectedPage;
  late final PageController _pageController;
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          actions: [Languages()],
          backgroundColor: Colors.white,
          title: Text(
            'Skip',
            style: TextStyle(color: Colors.blue.shade900, fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 550,
                    child: Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            selectedPage = page;
                          });
                        },
                        children: List.generate(
                          widget.icons.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.icons[index],
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Text(
                                    widget.title[index],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(71, 71, 71, 1),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Text(widget.texts[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black45)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PageViewDotIndicator(
                      currentItem: selectedPage,
                      count: widget.icons.length,
                      unselectedColor: Colors.black26,
                      selectedColor: Colors.amber.shade900,
                      duration: _kDuration,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedPage != 0
                    ? InkWell(
                        child: backButton(),
                        onTap: () {
                          setState(() {
                            _pageController.previousPage(
                                duration: _kDuration, curve: _kCurve);
                          });
                        },
                      )
                    : const SizedBox(
                        width: 120,
                        height: 50,
                      ),
                const SizedBox(width: 100),
                InkWell(
                  child: nextbutton(),
                  onTap: () {
                    selectedPage == 2
                        ? Navigator.pushNamed(context, '/checking')
                        : setState(
                            () {
                              _pageController.nextPage(
                                  duration: _kDuration, curve: _kCurve);
                            },
                          );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget backButton() {
  return Container(
    width: 95,
    height: 50,
    child: Center(
      child: Text(
        'Back',
        style: TextStyle(
            color: Colors.blue.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.blue.shade900,
      ),
    ),
  );
}

Widget nextbutton() {
  return Container(
    width: 95,
    height: 50,
    child: const Center(
      child: Text(
        'Next',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.amber.shade900,
    ),
  );
}
