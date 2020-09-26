import 'package:virus_total_api/models/photos/src.dart';

class Photo {
  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographerurl;
  final int photographerid;
  final Src src;
  final bool liked;

  Photo({this.id, this.width, this.height, this.url, this.photographer,
      this.photographerurl, this.photographerid, this.src, this.liked});
  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerurl: json['photographer_url'],
      photographerid: json['photographer_id'],
      src: Src.fromJson(json['src']),
      liked: json['liked']
    );
  }
}