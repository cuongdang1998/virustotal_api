import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/comments.dart';

abstract class CommentState extends Equatable{

  @override
  List<Object> get props =>[];
}
// Fetch Comment State
class InitialGetCommentState extends CommentState{}
class LoadingGetCommentState extends CommentState{}
class SucceededGetCommentState extends CommentState{
  final List<Comment> comments;
  SucceededGetCommentState({this.comments});
  @override
  List<Object> get props =>[comments];
}
class FailedGetCommentState extends CommentState{}

// Put comment state
class InitialPutCommentState extends CommentState{}
class LoadingPutCommentState extends CommentState{}
class SuccceedPutCommentState extends CommentState{
  final String result;
  SuccceedPutCommentState({this.result});
  @override
  List<Object> get props =>[result];
}
class FailedPutCommentState extends CommentState{}