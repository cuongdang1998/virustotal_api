import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState>{
  LikeBloc() : super(DisLikeActionState());

  @override
  Stream<LikeState> mapEventToState(LikeEvent event) async* {
    if(event is DisLikeAction){
      yield DisLikeActionState();
    }
    if(event is LikeAction)
    {
      yield LikeActionState();
    }
  }

}