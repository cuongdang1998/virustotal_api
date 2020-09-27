import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchPhotoEvent extends PhotoEvent{

}
class SeePhotoEvent extends PhotoEvent{
  final int id;

  SeePhotoEvent({this.id});
}
class SearchEvent extends PhotoEvent{
  final String query;

  SearchEvent({this.query});
}