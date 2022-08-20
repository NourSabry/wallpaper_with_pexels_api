// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget AppBarName() {
  return RichText(
    text: const TextSpan(
      text: 'Your',
      style: TextStyle(
          color: Colors.pink, fontWeight: FontWeight.w600, fontSize: 20),
      children: <TextSpan>[
        TextSpan(
            text: 'Wall',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
        TextSpan(
          text: 'Paper',
          style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
