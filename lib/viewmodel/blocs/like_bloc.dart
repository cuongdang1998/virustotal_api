import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState>{
  LikeBloc() : super(LikeState.UnLikedState);

  @override
  Stream<LikeState> mapEventToState(LikeEvent event) async* {
    switch(event){
      case LikeEvent.liked:
        yield LikeState.LikedState;
        break;
      case LikeEvent.unliked:
        yield LikeState.UnLikedState;
        break;
    }
  }

}