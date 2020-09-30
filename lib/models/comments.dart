import 'package:equatable/equatable.dart';
class Comment extends Equatable{
  final String date;
  final String commentcontent;

  Comment({this.date, this.commentcontent});
  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
      date: json['date'],
      commentcontent: json['comment']
    );
  }

  @override
  List<Object> get props => [];
}
class Comments extends Equatable{
  final int responsecode;
  final String resource;
  final String verbosemsg;
  final List<Comment> comments;

  Comments({this.responsecode, this.resource, this.verbosemsg, this.comments});
  factory Comments.fromJson(Map<String, dynamic> json){
    return Comments(
      responsecode: json['response_code'],
      resource: json['resource'],
      verbosemsg: json['verbose_msg'],
      comments: (json['comments'] as List).map((e) => Comment.fromJson(e)).toList()
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [resource];
}