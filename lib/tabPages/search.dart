import 'package:dukanda_ishgar/services/clientsCard.dart';
import 'package:dukanda_ishgar/tabPages/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/requests.dart';

class MySearch extends StatefulWidget {
  const MySearch({Key? key}) : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientCard>(builder: (context, value, child) {
      return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54)),
              child: Center(
                child: Form(
                  child: TextFormField(
                      onFieldSubmitted: ((text) {
                        context.read<Services>().getItemsBySearch(search: text);
                      }),
                      onChanged: ((text) {
                        context.read<Services>().getItemsBySearch(search: text);
                        setState(() {});
                      }),
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: "Gozleg",
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.black54,
                          ),
                          border: InputBorder.none)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: SerchHistoryCard(controller: textController)),
          ]));
    });
  }
}
