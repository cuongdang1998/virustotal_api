import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/photos/photo.dart';

class SearchPhoto extends Equatable{
  SearchPhoto({
    this.totalresults,
    this.prevPage,
    this.page,
    this.perPage,
    this.photos,
    this.nextPage,
  });
  final int totalresults;
  final int page;
  final int perPage;
  final List<Photo> photos;
  final String nextPage;
  final String prevPage;
  factory SearchPhoto.fromJson(Map<String, dynamic> json) => SearchPhoto(
    totalresults: json['total_results'],
    page: json["page"],
    perPage: json["per_page"],
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    nextPage: json["next_page"],
    prevPage: json["prev_page"],
  );

  @override
  List<Object> get props => [];
}