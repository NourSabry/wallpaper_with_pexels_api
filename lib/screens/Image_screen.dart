// ignore_for_file: use_build_context_synchronously, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_typing_uninitialized_variables, file_names

import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/components/container_image_screen.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/providers/fav_wallpaper.dart';

class ImageView extends StatefulWidget {
  final List<PhotosModel>? wallpaperList;

  final String? imgPath;

  const ImageView({@required this.imgPath, this.wallpaperList});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  @override
  Widget build(BuildContext context) {
    var favWallpaperManager = Provider.of<FavWallpaperManager>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath!,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgPath!, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: widget.imgPath!,
                      placeholder: (context, url) => Container(
                        color: const Color(0xfff5f8fd),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      // if (kIsWeb) {
                      //   _launchURL(widget.imgPath!);
                      // } else {
                      //   _save();
                      // }
                      // ImageDownloader.downloadImage(photoModel.src!.portrait);
                      _save();
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        ContainerImageScreen(),
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Favourite",
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgPath!,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await Permission.camera.request();
    } else {
      await Permission.camera.status;
    }
  }
}
