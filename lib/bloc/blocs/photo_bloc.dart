import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/services/fetch_photo.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState>{
  PhotoBloc() : super(InitialFetchPhotoState());
  int page=1;

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    var currentState=state;
    if(event is FetchPhotoEvent && !_hasReachedMax(currentState)){
      try{
        if(currentState is InitialFetchPhotoState){
          final photos=await fetchPhoto(page);
          yield SucceedFetchPhotoState(photos: photos, hasReachedMax:  false);
        }
        if(currentState is SucceedFetchPhotoState){
          final photos=await fetchPhoto(page++);
          yield photos.isEmpty ? currentState.copyWith(hasReachedMax: true):
              SucceedFetchPhotoState
                (photos: currentState.photos+photos,
                  hasReachedMax: false
              );
        }
      }
      catch(_){
        yield FailedFetchPhotoState();
      }
    }
    if(event is SeePhotoEvent){
      try{
        final photo= await getAPhoto(event.id);
        yield SucceedSeePhotoSate(photo: photo);
      }catch(_){
        yield FailedSeePhotoSate();
      }
    }
  }
  bool _hasReachedMax(PhotoState state){
    return state is SucceedFetchPhotoState &&  state.hasReachedMax;
  }

}