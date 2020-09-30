import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/models/photos/photo.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/services/fetch_photo.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState>{
  PhotoBloc() : super(InitialPhotoState());
  int page=1;
  bool reachedPageMax=false;
  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    var currentState=state;
    if(event is FetchPhotoEvent && !_hasReachedMax(currentState)){
      try{
        if(currentState is InitialPhotoState){
          final photos=await fetchPhoto(page);
          yield SucceedFetchPhotoState(photos: photos, hasReachedMax:  false);
        }
        if(currentState is SucceedFetchPhotoState){
          page++;
          final photos=await fetchPhoto(page);
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
    if(event is SearchEvent){
      yield LoadingSearchState();
      try{
        var searchphoto=await fetchSearchPhoto(event.query,page);
        page++;
        if(page>searchphoto.totalresults){
          reachedPageMax=true;
        }
        yield SucceedSearchState(photos: searchphoto.photos.toList(),
          totalresults: searchphoto.totalresults, reachedPageMax: reachedPageMax
        );
      }catch(_){
        yield FailSearchState();
      }
    }
    // if(event is SearchMoreEvent){
    //   try{
    //     var searchphotos=await fetchSearchPhotoNextPage(event.nextpage);
    //     print(searchphotos.photos.toList());
    //     print(searchphotos.nextPage);
    //     yield SucceedSearchMoreState(photos: searchphotos.photos.toList(), nextpage: searchphotos.nextPage);
    //   }catch(_){
    //     yield FailSearchMoreState();
    //   }
    // }
  }
  bool _hasReachedMax(PhotoState state){
    return state is SucceedFetchPhotoState &&  state.hasReachedMax;
  }

}