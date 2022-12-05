import 'package:dukanda_ishgar/buttons.dart';
import 'package:dukanda_ishgar/services/clientsCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientCard>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            value.users.isEmpty
                ? Container(
                    width: 371,
                    height: 161,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Bahalary müşdera görä aýdyp bilmek üçin ulanyjy kartyny goşuň ',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                            child: button('Kart gosh', Colors.amber.shade900),
                            onTap: () => Navigator.pushNamed(
                                context, '/clientCardReader'))
                      ],
                    ),
                  )
                : userCard(value.user?.name ?? 'No name',
                    value.user?.code ?? 'No code', context, value.user),
            value.previousUser.isNotEmpty
                ? ExpansionTile(
                    textColor: Colors.black,
                    initiallyExpanded: true,
                    title: const Text(
                      'Öň okadylan müşderi kartlary:',
                    ),
                    children: List.generate(
                        value.previousUser.length,
                        (index) => GestureDetector(
                              onTap: (() => setState(() {
                                    context
                                        .read<ClientCard>()
                                        .addToUsers(value.previousUser[index]);
                                    context
                                        .read<ClientCard>()
                                        .cleanThePreviousUserList(
                                            value.previousUser[index]);
                                  })),
                              child: ListTile(
                                leading: const CircleAvatar(),
                                title: Text(value.previousUser[index].name),
                                subtitle: Text(value.previousUser[index].code),
                              ),
                            )),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}

Widget userCard(String name, String code, BuildContext context, user) {
  return Container(
      width: 371,
      height: 161,
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ListTile(
          leading: const CircleAvatar(
            child: Text('Ck'),
          ),
          title: Text(name),
          subtitle: Text('Kart belgisi: $code'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: button('Çalyş', Colors.amber.shade900),
              onTap: () {
                Navigator.pushNamed(context, '/clientCardReader');
              },
            ),
            GestureDetector(
              child: button('Aýyrmak', Colors.red),
              onTap: () {
                context.read<ClientCard>().cleanTheUsersList();
                context.read<ClientCard>().addToTheList(user);
              },
            )
          ],
        )
      ]));
}
