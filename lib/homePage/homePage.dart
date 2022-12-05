import 'package:dukanda_ishgar/buttons.dart';
import 'package:dukanda_ishgar/homePage/drawer.dart';
import 'package:dukanda_ishgar/tabPages/barcodeQr.dart';
import 'package:dukanda_ishgar/tabPages/history.dart';
import 'package:dukanda_ishgar/tabPages/search.dart';
import 'package:dukanda_ishgar/tabPages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, selectedPage}) : super(key: key);
  int? selectedPage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            "Haryt gozlegi",
            style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: DefaultTabController(
        initialIndex: widget.selectedPage ?? 0,
        length: 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.amber.shade900,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.amber.shade900,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                onTap: (value) {},
                tabs: [
                  Tab(
                    child: SvgPicture.asset(
                      'assets/search.svg',
                    ),
                  ),
                  Tab(
                    child: SvgPicture.asset(
                      'assets/qr-code.svg',
                    ),
                  ),
                  Tab(child: SvgPicture.asset('assets/user.svg')),
                  Tab(child: SvgPicture.asset('assets/stopwatch.svg')),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  MySearch(),
                  BarcodeQrRaeder(),
                  User(),
                  History()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
