import 'package:flutter/material.dart';

Widget itemCard(
    {required List images, String? smallImg, name, mainUnit, code}) {
  print(smallImg);
  return Card(
    child: Row(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Image(
              image: images.isNotEmpty
                  ? NetworkImage(
                      'https://timar.com.tm/api/images/items/$smallImg')
                  : const NetworkImage('https://i.stack.imgur.com/ILTQq.png')),
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
                  name,
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
                mainUnit,
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
                '$code',
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
