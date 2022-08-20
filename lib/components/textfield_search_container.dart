// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/search_screen.dart';

class TextFieldSearchContainer extends StatelessWidget {
  final String? hint;

  TextFieldSearchContainer({this.hint});
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 232, 235),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: searchController,
            decoration:
                InputDecoration(hintText: hint!, border: InputBorder.none),
          )),
          InkWell(
              onTap: () {
                if (searchController.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                                search: searchController.text,
                              )));
                }
              },
              child: const Icon(Icons.search))
        ],
      ),
    );
  }
}
