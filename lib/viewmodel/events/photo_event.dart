import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable{
  @override
  List<Object> get props => [];
}
// Fetch curated photo
class FetchPhotoEvent extends PhotoEvent{

}
// Get a photo
class SeePhotoEvent extends PhotoEvent{
  final int id;

  SeePhotoEvent({this.id});
}
// Search event
class SearchEvent extends PhotoEvent{
  final String query;

  SearchEvent({this.query});
}
// Load more photo search
// class SearchMoreEvent extends PhotoEvent{
//   final String nextpage;
//
//   SearchMoreEvent({this.nextpage});
// }