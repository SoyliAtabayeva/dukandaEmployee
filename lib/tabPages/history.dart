import 'package:dukanda_ishgar/services/itemBarcodeRequest.dart';

import 'package:dukanda_ishgar/tabPages/itemCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../buttons.dart';
import '../homePage/homePage.dart';
import 'bottomSheet.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return context.read<ItemId>().seenItem.isEmpty
        ? Center(
            child: SizedBox(
              width: 371,
              height: 161,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Haryt gyzyklanma taryhyňyz programmadan täzeden açylanda pozulýar. ',
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: button('Haryt gozle', Colors.amber.shade900),
                        onTap: () => setState(
                          () {
                            Navigator.pushNamed(context, '/homePage');
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: button(
                          'Haryt QR-okat',
                          const Color(0xFFFF6F00),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => HomePage(
                                  selectedPage: 1,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Consumer<ItemId>(
            builder: (
              context,
              value,
              child,
            ) {
              var item = value.seenItem;

              return ListView.builder(
                itemCount: value.seenItem.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      settingModalBottomSheet(context, true);
                    },
                    child: itemCard(
                        images: item[index]?.images ?? [],
                        smallImg: item[index]?.smallImg,
                        name: item[index]?.name,
                        mainUnit: item[index]?.mainGroup,
                        code: item[index]?.code),
                  );
                }),
              );
            },
          );
  }
}
