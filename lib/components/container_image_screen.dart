// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContainerImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white24, width: 1),
            borderRadius: BorderRadius.circular(40),
            gradient: const LinearGradient(
                colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              "download Wallpaper",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 1,
            ),
            const Text(
              kIsWeb
                  ? "Image will open to be  downloaded"
                  : "Image will be saved in gallery",
              style: TextStyle(fontSize: 8, color: Colors.white70),
            ),
          ],
        ));
  }
}
