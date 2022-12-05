import 'package:flutter/material.dart';

const List<String> list = ["TM", "Ru"];

class Languages extends StatefulWidget {
  String dropdownValue = list.first;

  Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      style: const TextStyle(color: Colors.black87, fontSize: 16),
      onChanged: (String? value) {
        setState(() {
          widget.dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class PopMenuButton extends StatefulWidget {
  const PopMenuButton({Key? key}) : super(key: key);

  @override
  State<PopMenuButton> createState() => _PopMenuButtonState();
}

class _PopMenuButtonState extends State<PopMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Material(
        child: Text(
          'TM',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text(
            "Ru",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
