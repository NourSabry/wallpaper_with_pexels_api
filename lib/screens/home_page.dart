// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/components/appbar_text.dart';
import 'package:wallpaper_app/components/row_information.dart';
import 'package:wallpaper_app/data/data.dart';
import 'dart:convert';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/screens/search_screen.dart';

import '../components/wallpaper_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int noOfImageToLoad = 30;
  List<PhotosModel> photos = [];

  getTrendingWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1"),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AppBarName(),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.star_outlined, color: Colors.black)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 227, 231),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "search what you need..",
                        border: InputBorder.none),
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
                      child: Icon(Icons.search))
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RowInformation(
              label: "Made By: ",
              link: "https://www.linkedin.com/in/nour-sabrii-59b4b9213",
              value: "Nourhan Sabry",
            ),
            SizedBox(
              height: 16,
            ),
            wallPaper(photos, context),
            SizedBox(
              height: 24,
            ),
            RowInformation(
              label: "Photos provided By ",
              link: "https://www.pexels.com/",
              value: "Pexels",
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
