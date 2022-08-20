// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RowInformation extends StatelessWidget {
  final String? label;
  final String? link;
  final String? value;

  RowInformation({this.label, this.link, this.value});
  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label!,
          style: const TextStyle(
              color: Colors.black54, fontSize: 12, fontFamily: 'Overpass'),
        ),
        GestureDetector(
          onTap: () {
            _launchURL(link!);
          },
          child: Text(
            value!,
            style: const TextStyle(
                color: Colors.pink, fontSize: 12, fontFamily: 'Overpass'),
          ),
        ),
      ],
    );
  }
}
