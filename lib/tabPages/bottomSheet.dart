import 'package:dukanda_ishgar/tabPages/bottomSheet_Stock.dart';
import 'package:dukanda_ishgar/tabPages/bottomSheet_product.dart';

import 'package:flutter/material.dart';

void settingModalBottomSheet(context, bool check) {
  showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (BuildContext bc) {
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 45, bottom: 16),
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.amber.shade900,
                  unselectedLabelColor: Colors.black87,
                  labelStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Colors.amber.shade900),
                  indicatorColor: Colors.amber.shade900,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Haryt',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Stock',
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ButtomSheetProduct(
                        check: check,
                      ),
                      bottomSheetStock(check)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
