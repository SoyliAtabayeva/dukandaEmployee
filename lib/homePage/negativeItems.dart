import 'package:dukanda_ishgar/services/negatives.dart';
import 'package:dukanda_ishgar/tabPages/itemCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../buttons.dart';
import '../tabPages/bottomSheet.dart';
import 'drawer.dart';

class NegativeItems extends StatefulWidget {
  const NegativeItems({Key? key}) : super(key: key);

  @override
  State<NegativeItems> createState() => _NegativeItemsState();
}

class _NegativeItemsState extends State<NegativeItems> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController? _scrollController;

  _scrollListener() {
    if (_scrollController?.position.pixels ==
        _scrollController?.position.maxScrollExtent) {
      context.read<Negatives>().negative(context);
    }
  }

  @override
  void initState() {
    context.read<Negatives>().negative(context);
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() => scaffoldKey.currentState?.openDrawer()),
            icon: SvgPicture.asset('assets/MenuIcon.svg')),
        elevation: 0,
        actions: const [PopUpButton()],
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Negative-0",
            style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Consumer<Negatives>(
        builder: (context, value, child) {
          var item = value.negativeItems;
          return ListView.builder(
            controller: _scrollController,
            itemCount: item.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  settingModalBottomSheet(context, true);
                },
                child: itemCard(
                    images: item,
                    smallImg: value.localImages[index].smallImg,
                    name: item[index].name,
                    mainUnit: item[index].mainUnit,
                    code: item[index].code),
              );
            }),
          );
        },
      ),
    );
  }
}
