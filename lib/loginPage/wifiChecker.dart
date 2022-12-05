import 'package:flutter/material.dart';

class WifiCheckerPage extends StatefulWidget {
  const WifiCheckerPage({Key? key}) : super(key: key);

  @override
  State<WifiCheckerPage> createState() => _WifiCheckerPageState();
}

class _WifiCheckerPageState extends State<WifiCheckerPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/DukandaIshgar.png',
            width: 260,
            height: 95,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'wersiýa 1.0.0',
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
