import 'package:equatable/equatable.dart';

abstract class LikeEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class LikeAction extends LikeEvent{}
class DisLikeAction extends LikeEvent{}