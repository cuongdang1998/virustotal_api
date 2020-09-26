import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
import 'package:virus_total_api/services/fetch_comments.dart';
import 'package:virus_total_api/services/put_comment.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState>{
  CommentBloc(CommentState initialState) : super(initialState);
  FetchComments fComments=FetchComments();
  PutComments pComments=PutComments();
  @override
  Stream<CommentState> mapEventToState(CommentEvent event)async* {
    switch(event.runtimeType){
      case FetchCommentEvent:
        yield LoadingGetCommentState();
        try{
          var comments=await fComments.fetchComments();
          yield SucceededGetCommentState(comments: comments);
          print(state);
        }catch(_){
          yield FailedGetCommentState();
        }
        break;

      case PutCommentEvent:
        yield LoadingPutCommentState();
        try{
          var result= await pComments.putComment();
          yield SuccceedPutCommentState(result: result);
        }catch(_){
          yield FailedPutCommentState();
        }
        break;
      default:
    }

  }
}