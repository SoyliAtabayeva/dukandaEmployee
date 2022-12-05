import 'dart:developer';

import 'package:dukanda_ishgar/buttons.dart';

import 'package:dukanda_ishgar/services/location.dart';
import 'package:dukanda_ishgar/services/location_employee.dart';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';

import '../services/requests.dart';
import '../services/shared_preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool b = true;
  List<String> data = [];
  final key = GlobalKey<FormState>();
  List<String> hint = ['ady', 'password'];
  List<TextEditingController> textEditorController = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<MyLocation>(context, listen: true);

    bool check = false;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Form(
        key: key,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Programmamyzyň mümkinçiliklerinden ulgamagirmek arkaly peýdalanyp bilersiňiz.',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if ((value?.length ?? 0) < 2) {
                            check = false;
                            return 'Wrong!';
                          } else {
                            setState(
                              () {
                                check = true;
                              },
                            );
                            return null;
                          }
                        },
                        controller: textEditorController[index],
                        decoration: InputDecoration(
                          hintText: hint[index],
                          fillColor: const Color.fromRGBO(238, 238, 238, 1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1)),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1)),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1)),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: button('Login', Colors.amber.shade900),
                      onTap: () async {
                        if (key.currentState?.validate() ?? false) {
                          bool check = await context.read<Services>().login(
                              textEditorController[0].text,
                              textEditorController[1].text,
                              context.read<Prefs>().getScannedData);
                          if (context.read<Services>().user?.token != null) {
                            Navigator.pushNamed(context, '/homePage');
                          } else {
                            final snackBar = SnackBar(
                              content: Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text('Nadogry maglumat'))),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
