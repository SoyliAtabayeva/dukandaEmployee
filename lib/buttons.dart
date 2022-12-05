import 'package:flutter/material.dart';

Widget button(String text, Color color) {
  return Container(
    width: 130,
    height: 40,
    child: Center(
        child: Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
    )),
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
  );
}

class PopUpButton extends StatefulWidget {
  const PopUpButton({Key? key}) : super(key: key);

  @override
  State<PopUpButton> createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Material(
        child: Text(
          'TM',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'poppins',
            fontSize: 16,
          ),
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text(
            "Ru",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
