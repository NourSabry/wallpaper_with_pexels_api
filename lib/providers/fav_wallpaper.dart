import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/photos_model.dart';

class FavWallpaperManager extends ChangeNotifier {
  void addToFav(PhotosModel wallpaper) {
    var list = Hive.box(FAV_BOX).get(FAV_LIST_KEY);

    if (!list.contains(wallpaper.id)) {
      list.add(wallpaper.id);
      Hive.box(FAV_BOX).put(FAV_LIST_KEY, list);

      notifyListeners();
    }
  }

  void removeFromFav(PhotosModel wallpaper) {
    var list = Hive.box(FAV_BOX).get(FAV_LIST_KEY);

    if (list.remove(wallpaper.id)) {
      Hive.box(FAV_BOX).put(FAV_LIST_KEY, list);

      notifyListeners();
    }
  }

  bool isFavorite(PhotosModel wallpaper) {
    return Hive.box(FAV_BOX).get(FAV_LIST_KEY).contains(wallpaper.id);
  }
}
