import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/photos/photo.dart';
import 'package:virus_total_api/models/photos/search_photo.dart';

abstract class PhotoState extends Equatable{
  const PhotoState();
  @override
  List<Object> get props => [];
}

//Fetch photo
class InitialFetchPhotoState extends PhotoState{}
class SucceedFetchPhotoState extends PhotoState{
  final List<Photo> photos;
  final bool hasReachedMax;

  const SucceedFetchPhotoState({this.photos, this.hasReachedMax});
  SucceedFetchPhotoState copyWith({List<Photo> photos, bool hasReachedMax})
  {
    return SucceedFetchPhotoState(
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  List<Object> get props =>[photos,hasReachedMax];
}
class FailedFetchPhotoState extends PhotoState{}

//See a photo
class SucceedSeePhotoSate extends PhotoState{
  final Photo photo;
  SucceedSeePhotoSate({this.photo});
}
class FailedSeePhotoSate extends PhotoState{}

//Fetch SearchPhoto photo list
//class InitialSearchState extends PhotoState{}
class LoadingSearchState extends PhotoState{}
class SucceedSearchState extends PhotoState{
  final List<Photo> photos;

  SucceedSearchState({this.photos});
}
class FailSearchState extends PhotoState{}