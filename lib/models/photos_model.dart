import 'package:cloud_firestore/cloud_firestore.dart';

class PhotosModel {
  String? url;
  SrcModel? src;
  bool? isFavorite;
    final String? id;


  PhotosModel({this.url, this.isFavorite, this.src, this.id});

  PhotosModel.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : isFavorite = false,
    id = snapshot.id;

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        url: parsedJson["url"], src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String? portrait;
  String? large;
  String? landscape;
  String? medium;

  SrcModel({this.portrait, this.landscape, this.large, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
