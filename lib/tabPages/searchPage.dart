import 'package:dukanda_ishgar/services/clientsCard.dart';

import 'package:dukanda_ishgar/services/itemBarcodeRequest.dart';
import 'package:dukanda_ishgar/services/model.dart';
import 'package:dukanda_ishgar/services/requests.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottomSheet.dart';

class SerchHistoryCard extends StatefulWidget {
  const SerchHistoryCard({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  State<SerchHistoryCard> createState() => _SercHistoryCardtate();
}

class _SercHistoryCardtate extends State<SerchHistoryCard> {
  ScrollController? _scrollController;

  _scrollListener() {
    if (_scrollController?.position.pixels ==
        _scrollController?.position.maxScrollExtent) {
      context
          .read<Services>()
          .getItemsBySearch(search: widget.controller?.text);
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Services>(builder: (context, value, child) {
      return ListView.builder(
          controller: _scrollController,
          itemCount: value.searchedItems.length,
          itemBuilder: ((context, index) {
            Product? item = value.searchedItems[index];
            return GestureDetector(
              onTap: () {
                settingModalBottomSheet(context, true);

                context.read<ItemId>().getItemById(
                    id: item.id ?? 0,
                    user: context.read<ClientCard>().users,
                    context: context,
                    clientId: context.read<ClientCard>().user?.id,
                    cardNo: context.read<ClientCard>().user?.cardNo);

                setState(() {});
              },
              child: Card(
                  child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image(
                        image: item.images?.isNotEmpty ?? false
                            ? NetworkImage(
                                'https://timar.com.tm/api/images/items/${item.images?.first.smallImg}')
                            : const NetworkImage(
                                'https://i.stack.imgur.com/ILTQq.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 30,
                            child: Text(
                              item.nameTm ?? '',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            item.mainUnit ?? 'null',
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${item.code}',
                            style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          )
                        ]),
                  )
                ],
              )),
            );
          }));
    });
  }
}
