import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'components/create_comment_body.dart';
class CreateCommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<CommentBloc>(
            create: (context) => CommentBloc(InitialPutCommentState()),
            child: CreateCommentBody()
        )
    );
  }
}
