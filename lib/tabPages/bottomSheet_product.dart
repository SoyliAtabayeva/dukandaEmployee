import 'package:dukanda_ishgar/services/clientsCard.dart';
import 'package:dukanda_ishgar/services/itemBarcodeRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/model.dart';

class ButtomSheetProduct extends StatefulWidget {
  const ButtomSheetProduct({Key? key, this.check}) : super(key: key);
  final bool? check;

  @override
  State<ButtomSheetProduct> createState() => _ButtomSheetProductState();
}

class _ButtomSheetProductState extends State<ButtomSheetProduct> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemId>(builder: (context, value, child) {
      Product? object =
          widget.check == true ? value.objectId : value.objectBarcode;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Stack(
              children: [
                Image(
                    image: object?.bigImg != null
                        ? NetworkImage(
                            'https://timar.com.tm/api/images/items/${object?.bigImg}')
                        : const NetworkImage(
                            'https://i.stack.imgur.com/ILTQq.png')),
                Positioned(
                    right: 0,
                    top: 15,
                    child: object?.discount != 0
                        ? Container(
                            width: 56,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.amber.shade900),
                            child: Center(
                              child: Text(
                                '${object?.discount}%',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : const Text('')),
              ],
            ),
            object?.images?.length != 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                        object?.images?.length ?? 0,
                        (index) => Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(0, 0, 0, 0.15))),
                            child: Image(
                                image: NetworkImage(
                                    'https://timar.com.tm/api/images/items/${object?.images?[index].smallImg}')))))
                : Container(),
            const SizedBox(
              width: 30,
            ),
            Text(
              object?.name ?? 'null',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 40,
            ),
            context.read<ClientCard>().users.isNotEmpty
                ? Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12)),
                    child: Center(
                      child: ListTile(
                        title:
                            Text(context.read<ClientCard>().user?.name ?? ''),
                        subtitle: Text(
                            'Kart belgisi:${context.read<ClientCard>().user?.code ?? ''}'),
                        trailing: CloseButton(
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                context.read<ClientCard>().cleanTheUsersList();
                                context.read<ItemId>().getItemById(
                                    id: object?.id ?? 0,
                                    user: context.read<ClientCard>().users,
                                    context: context,
                                    clientId:
                                        context.read<ClientCard>().user?.id,
                                    cardNo: context
                                        .read<ClientCard>()
                                        .user
                                        ?.cardNo);
                                context.read<ClientCard>().addToTheList(
                                    context.read<ClientCard>().user);
                              });
                            }),
                      ),
                    ),
                  )
                : const Text(
                    '',
                  ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${object?.currency}  ${object?.price}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.lineThrough,
                      color: Color.fromRGBO(169, 186, 192, 1)),
                ),
                Text(
                  '${object?.currency}  ${object?.discountPrice}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: Colors.amber.shade900),
                ),
                Container(
                  width: 56,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(08, 147, 163, 1)),
                  child: Center(
                    child: Text(
                      '${object?.unitCount} sany',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            productInfo('Kody', object?.code ?? 'null'),
            productInfo('Kategoriýasy', object?.mainGroup ?? ''),
            productInfo('Ölçeg birligi ', object?.unit ?? 'null'),
            productInfo('Özel kody', object?.specode ?? ''),
          ],
        ),
      );
    });
  }
}

Widget productInfo(String title, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        SizedBox(
          width: 95,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                color: Colors.black87),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.black38),
        ),
      ],
    ),
  );
}
