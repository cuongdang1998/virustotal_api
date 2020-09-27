import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class FetchCommentEvent extends CommentEvent{
}
class PutCommentEvent extends CommentEvent{

}