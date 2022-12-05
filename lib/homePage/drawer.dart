import 'package:dukanda_ishgar/loginPage/checkingPage.dart';
import 'package:dukanda_ishgar/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../services/requests.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 770,
            child: Column(
              children: [
                DrawerHeader(child: Image.asset('assets/DukandaIshgar.png')),
                ListTile(
                  selectedTileColor: Colors.amber.shade900,
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/products.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Harytlar')
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/homePage');
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/sanaw.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Sanaw')
                    ],
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/Exchange.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Haryt teklibi')
                    ],
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/shoppingCard.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Sargytlar')
                    ],
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/emptyBox.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Negatiw-0')
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/negativeItems');
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset('assets/transphering.svg'),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text('Transferler')
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (() {
                      setState(
                        () {
                          context.read<Prefs>().deleteData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const CheckingPage())));
                        },
                      );
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/profile.svg'),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('${context.read<Services>().user?.fullName}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SvgPicture.asset('assets/logout.svg'),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Wersiya  1.0.0',
                    style: TextStyle(fontSize: 14, color: Colors.black26),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
