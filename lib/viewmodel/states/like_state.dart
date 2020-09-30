import 'package:equatable/equatable.dart';

abstract class LikeState extends Equatable{
  @override
  List<Object> get props => [];
}
class LikeActionState extends LikeState{}
class DisLikeActionState extends LikeState{}